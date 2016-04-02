#EasyLayout
* This is an library for AutoLayout like Masonry but more. Just for fun and self-use.

## How to use
* A View's left equal to B View's right with Margin 10.</br>

```
[AView makeConstraints:^(ELConstraintsMaker *make) {
    make.left.equalTo(BView.right).offset(10);
}];

```

* A View's centerX and centerY equal to superView's centerX and  centerY.</br>

```
[AView makeConstraints:^(ELConstraintsMaker *make) {
    make.centerXY.equalTo(@0);
}];

```
* A View's all edges equal to superView's all edges with margin 5.</br>

```
[AView makeConstraints:^(ELConstraintsMaker *make) {
    make.allEdges.equalTo(@5);
}];
```

### Just like masonry do, but you can combination any constraints together like this:

```
  [someView remakeConstraints:^(ELConstraintsMaker *make) {
  //left equal to _bView's right with margin 10 , top equal to 	_aView's bottom with margin 0
    make.combination(@[ ELLeft, ELTop ])
        .equalTo(@[ _bview.right, _aView.bottom ])
        .offsets(@[ @10, @0 ]);
        
    	//size equal to '_testView'
    make.size.equalTo(_testView);
  }];

```

## Next to do
* A tutorial for how to build it
* More convinience class (linear layout ?)
* Swift Version

## License (MIT)
