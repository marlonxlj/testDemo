##表格性能优化

####时间:2017-1-16

1. xcode 查找快捷键:`command + shift + o`
2. 进入到当前这个文件:`command + shift + j`
3. 选择替换:`commadn+shift+e`

###Xcode常用功能和快捷键

Command+[ -> 代码块左移

Comamnd+] -> 代码块右移

Tab -> 接受代码自动完成提示

Esc -> 显示代码提示

Command+B -> 编译

Command+R -> 运行

Control+F -> 前移光标

Control+B -> 后移光标

Control+P -> 光标移到上一行

Control+N -> 光标移到下一行

Control+A -> 光标移到行首

Control+E -> 光标移到行尾

Control+T -> 交换光标左右字符

Control+D -> 删除光标右边的字符

Control+K -> 删除本行

Control+L -> 将光标所在位置置于窗口中央

按住Option双击鼠标 -> 搜索文档

Command+Y -> 激活/禁用断电

Command+Control+Y -> 继续运行

F6 -> 单步跳过

F7 -> 单步跳入

F8 -> 跳出

Cocoa Touch 框架:

---

|Cocoa Touch Layer|
|---|
|Media Layer|
|Core Services Layer|
|Core OS Layer|

-
#
####从上到下依次为Cocoa Touch、Media、Core Services、Core OS。
Cocoa Touch层：包含创建iOS应用程序所需的关键框架。上至实现应用程序可视界面，下至与高级系统服务交互，都需要该层技术提供底层基础。基本系统服务和关键框架（Address Book UI、UIKit等）`UIKit Framework`

- Media层：包含图形技术、音频技术和视频技术，这些技术相互结合就可为移动设备带来最好的多媒体体验，更重要的是，它们让创建外观音效俱佳的应用程序变得更加容易。`Core Graphics Framework`,`Core Animation Framewrok`,`AV Foundation Framework`

- Core Services层：为所有的应用程序提供基础系统服务。可能应用程序并不直接使用这些服务，但它们是系统很多部分赖以建构的基础。`Core Data Framewrok`, `Core Foundation Framework`,`Foundation Framework`

- Core OS层：Core OS层的底层功能是很多其他技术的构建基础。通常情况下，这些功能不会直接应用于应用程序，而是应用于其他框架。但是，在直接处理安全事务或和某个外设通信的时候，必须要应用到该层的框架。
`Accelerate Framework`,`System Framework`
---

###SDWebImage Gif处理利用ImageIO的函数
###内存问题：内存释放不会立即执行，播放动图，但是会占用大量的内存
###解决办法:
1.开启一个时间,CADisplayLink(每次屏幕屏幕都会触发)
2.每次触发，递增index只加载一帧,之前的图像立即释放

YY_WebImage 如果要显示动图，需要使用`YYAnimatedImageView`
利用KVC修改imageView的类型
`[self setValue:[[YYAnimatedImageView alloc] init] forKey:@"imageView"]`

```
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
	//获取到gif动图的帧数
    size_t count = CGImageSourceGetCount(source);

    UIImage *animatedImage;
	//判断图片数量，如果是1，直接返回静态图像
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
    	 //创建图像数据:真正消耗性能的根源
        NSMutableArray *images = [NSMutableArray array];

        NSTimeInterval duration = 0.0f;

        for (size_t i = 0; i < count; i++) {
        	 //取出第i帧
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
				//累加时长
            duration += [self sd_frameDurationAtIndex:i source:source];
				//把图像添加到数据
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
				//释放图像
            CGImageRelease(image);
        }

        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
		 //设置动图数组
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }

    CFRelease(source);

    return animatedImage;

```


###表格性能测试,一定要在真机上运行，真机的内存比模拟器小很多,CPU架构和模拟器完全不一样

模拟器:`Color Offscreen-Rendered`离屏幕渲染

###Debug Options:
- Color Blended Layers 混合图层
- Color Hits Green and Misses Red
- Color Copied Images
- Color Immediately
- Color Misaligned Images 图像拉伸的
- Color Offscreen_rendered Yellow 离屏幕渲染
- Color Compositing Fast-Path Blue
- Flash Updated Regions

###iOS Core Animation Advanced Techniques(中文).pdf中有三个重点需要看:性能调优、高效绘图、图层性能

###Cell表格性能优化:
- 行高一定要缓存
- 不要动态创建子视图
	- 所有的子视图都要预先创建
	- 如果不需要显示可以设置`hidden`
- 所有的子视图都应该添加到`contentView`上
- 所有的子视图都必须指定背景颜色
- 所有的颜色都不要使用`alpha`
- cell栅格化
- 异步绘制

```
//1.栅格化，美工术语:将cell中的所有内容，生成一张独立的图像，在屏幕滚动时，只显示图像
self.layer.shouldRasterize = YES;
//1.1 栅格化，必须指定分辨率，否则默认使用*1,生成图像
self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
//2. 异步绘制:如果cell比较复杂,可以使用 self.layer.drawsAsynchronously = YES;
```



你是怎么测试性能的呢？使用单元测试
对UI测试可以使用猴子测试

###AFN
1.图片太大，有可能不会缓存

2.使用的是系统默认的缓存

###提问:如果使用SDWebImage加载图像，会显示指示器吗？
###答:这个跟AFNetworking没有关系,不会显示指示器

####🐼🐶🐶如果对你有帮助，或觉得可以。请右上角star一下，这是对我一种鼓励，让我知道我写的东西有人认可，我才会后续不断的进行完善。

###有任何问题或建议请及时issues me，以便我能更快的进行更新修复。

####Email: marlonxlj@163.com