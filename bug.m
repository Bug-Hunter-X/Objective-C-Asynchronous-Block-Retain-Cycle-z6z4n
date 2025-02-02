In Objective-C, a common yet subtle issue arises when dealing with memory management and object lifecycles, especially when using blocks.  Consider this scenario: 

```objectivec
@property (nonatomic, strong) NSMutableArray *myArray;

- (void)someMethod {
    [self.myArray addObject:@"Hello"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Problem: This block retains 'self', creating a retain cycle
        [self.myArray addObject:@"World"];
    });
}
```

The problem lies in the asynchronous block. The block implicitly retains `self`. If `self` also retains `myArray`, and `myArray` retains its objects, a retain cycle is formed.  This can lead to memory leaks where `self` and `myArray` are never deallocated even after the object is no longer needed.