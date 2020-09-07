---
layout: article
title: "安全配置校园 Wifi — Tsinghua-Secure / PKU Secure"
key: 20200907
tags:
    - Tutorial / 搞机心得
mathjax_autoNumber: true
---

<!-- @import "../_includes/usermod/mathjax.html" -->

公共 Wifi 一般来说是比较危险的；只要设置一个和官方热点同名的“伪基站”，即可诱骗他人连接并窃取未加密的信息。考虑到 T 大校园内技术大神的密度 ![](/assets/coolemoji/weibo_dog10.png){:width="28px"} 这种危险大概是不可忽略的。好在学校现有的企业级热点 Tsinghua-Secure 可通过数字证书消除这一隐患（北大也有类似的热点：PKU Secure）。然而！官方提供的[配置指南](https://its.tsinghua.edu.cn/info/czsc/1893)却完全跳过了校验证书的配置... 经过两个晚上的折腾我终于搞清楚了这东西的配置方法，在此记录并分享给诸位。

**注：** 本文适用于 安卓 / Linux / Windows, 苹果的 MacOS / iOS 无需此操作。苹果系统在首次连接时似乎会自动缓存证书，后续连接则会比对首次连接的证书；因此只要保证第一次连接的热点是安全的，就没有问题。

<!-- more -->

## 具体步骤

一旦了解了校验证书的原理，具体的配置实际上是十分简单的；以安卓为例，[官方指南](https://its.tsinghua.edu.cn/info/czsc/1893)让我们选择“不认证 CA 证书”，这是不安全的选项；我们只需稍作修改：

- 在 **域名（domain）** 一栏填入：**`tsinghua.edu.cn`**
- 在 **CA 证书（CA certificate）** 一栏选择：**使用系统证书**

<img
  src="/assets/figs/tsinghua-secure-setting.png"
  style="width: 320px; max-width: 100%;"
/>

搞定！此后在连接 Tsinghua-Secure 热点时，系统会首先校验证书，确认热点的真实性，随后再进行连接。

**注：** Linux 下可能需要手动选择证书路径，而系统证书的位置可能依赖于具体发行版；本人使用基于 Arch 的 Manjaro 发行版，其系统证书位于 `/etc/ssl/cert.pem`. 其余发行版的证书路径可自行百度（google）。

### 附：手动安装证书

在发现上述简单办法之前，我并不知道可以直接使用系统证书，于是花了一晚上按照下述教程手动安装了数字证书：

- https://superuser.com/a/853602
- https://unix.stackexchange.com/a/214707

苹果系统缓存证书的过程应该就是这些步骤的自动化。然而，手动安装的证书过期后需要重新手动安装，但系统证书会随系统更新而更新，因此还是推荐前面“使用系统证书”的办法。

## 必要性

最后我们讨论一下为什么有必要校验热点的证书，尤其是在 T 大校内 ![](/assets/coolemoji/weibo_dog.png){:width="28px"} 事实上，如果传输数据经过加密，即使假冒热点拦截了传输的数据，也难以解密。PKU 的核心网站（its, portal, elective, course 等等）均采用了 `https://` 加密协议，且通过统一认证平台（https://iaaa.pku.edu.cn）跳转，因此大可不必担心热点的安全性。

<img
  src="/assets/figs/pku-portal-https.png"
  style="max-width: 100%;"
/>

PKU的统一认证入口（T 大也有类似的东西：id.tsinghua.edu.cn, 不过尚未广泛使用...）：

<img
  src="/assets/figs/pku-iaaa.png"
  style="max-width: 100%;"
/>

相反，清华校内有诸多核心服务（如 info, academic, 选课网 zhjwxk.cic 等等）**并没有加密**，仅采用不安全的 `http://` 协议，因此很有必要确认 Wifi 的安全性，否则可能被中间人攻击（Man-in-the-middle attack）。

<img
  src="/assets/figs/tsinghua-info-http.png"
  style="max-width: 100%;"
/>
