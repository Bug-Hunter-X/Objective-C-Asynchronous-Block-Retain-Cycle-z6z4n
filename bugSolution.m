The solution involves using `__weak` to break the retain cycle:

```objectivec
@property (nonatomic, strong) NSMutableArray *myArray;

- (void)someMethod {
    [self.myArray addObject:@"Hello"];
    __weak typeof(self) weakSelf = self; // Create a weak reference to self
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Use weakSelf to avoid retain cycle
        if (weakSelf) {
            [weakSelf.myArray addObject:@"World"];
        }
    });
}
```

By declaring `weakSelf` as a weak reference, the block no longer retains `self` strongly.  The `if (weakSelf)` check ensures that the code doesn't access `self` after it's been deallocated.