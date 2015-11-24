pub������
Application package Ӧ�ó����
A package that is not intended to be used as a library. Application packages may have dependencies on other packages, but are never depended on themselves. They are usually meant to be run directly, either on the command line or in a browser. The opposite of an application package is a library package.

������һ�������Ӧ�ó������������������������ϵ������������֮��û�С�����ͨ�����Ǳ�ֱ�����У������������У�������������У���������Եġ�

Application packages should check their lockfiles into source control, so that everyone working on the application and every location the application is deployed has a consistent set of dependencies. Because their dependencies are constrained by the lockfile, application packages usually specify any for their dependencies�� version constraints.
Ӧ�ó����Ӧ�ü�����ǵ�Դ��������е����ļ���ʹ��Ӧ�ó�����ص����ݲ����������ϵһ�¡���Ϊ���ǵ�������ϵ�����ļ�Լ����Ӧ�ó����ͨ�����оٳ�������ϵ��Լ���汾��

Asset �ʲ�

A resource��Dart, HTML, JavaScript, CSS, image, or anything else��intended to be part of a deployed package. The package can be a web app, a package used by a web app, or any other package that benefits from a build step. Tools such as pub serve and pub build take source assets (such as an HTML file, a CSS file, and several Dart files) and produce generated assets (such as the same HTML and CSS files, plus a single JavaScript file).
���ð��еĲ�����Դ������Dart, HTML, JavaScript, CSS, ͼ����������������������һ��web app��Ҳ�����Ǳ�web app��ʹ�õİ��������ǵ����ڴ˹����������������������pub serve��pub build���Ի�ȡԴ�ʲ�����һ��HTML�ļ���һ��CSS�ļ��ͼ���Dart�ļ����Ͳ��������ʲ�������ͬ��HTML��CSS�ļ�������һ��JavaScript�ļ�����

Assets fall into four groups, with some overlap:

Source asset: An actual, authored file on disk that pub build and pub serve can find and use.
Generated asset: An asset (possibly the output of a transformer) that��s either served by pub serve or saved to disk by pub build.
Input asset: An asset that is the input to a transformer. An input asset might be a source asset, or it might be the output of a transformer in a previous phase.
Output asset: An asset that is created by a transformer. An output asset might be a generated asset, or it might be the input to a transformer in a later phase.
�ʲ���Ϊ���࣬������Щ�ص���
Դ�ʲ���pub build��pub serve�����ҵ���ʹ�õĴ����е�������Ȩ�ļ���
�����ʲ�����pub server����Ķ�����߱�pub build �����ڴ����е��ʲ���
�����ʲ�:��һ��transformer�����ʲ���������ʲ�������Դ�ʲ�������������transformerǰһ�׶ε������
����ʲ�:��transformer������ʲ���������ʲ������������ʲ���������������transformer�ں�һ�׶�������ʲ���

Dependency
Another package that your package relies on. If your package wants to import code from some other package, that package must be a dependency. Dependencies are specified in your package��s pubspec and described in Pub Dependencies.
Dependency����ĳ������Ҫ��������һ�����������ĳ������Ҫ���������е���һЩ���룬����������Ƕ����ġ�����������ĳ�����С�pubspec�������岢����Pub Dependencies�б�������

Entrypoint ��ڵ�

Entrypoint is used to mean two things. In the general context of Dart, it is a Dart library that is directly invoked by a Dart implementation. When you reference a Dart library in a <script> tag or pass it as a command line argument to the standalone Dart VM, that library is the entrypoint. In other words, it��s usually the .dart file that contains main().
��ڵ�����ָ�����¡���һ���Dart�����У�Dart���ú���ֱ��Ԯ��Dart�⣬�������� <script>��ǩ�е� Dart �������Ϊ�����в������ݸ����� Dart VM ʱ���ÿ�����ڵ㡣���仰˵����ͨ���ǰ��� main () ��.dart �ļ���

In the context of pub, an entrypoint package or root package is the root of a dependency graph. It will usually be an application. When you run your app, it��s the entrypoint package. Every other package it depends on will not be an entrypoint in that context.
��Pub�����У���ڵ����root package����������������ͼ�ĸ�����ͨ����һ��Ӧ�á�������������Ӧ�ó���ʱ��������ڵ����ȡ��������ÿ����������������������µ���ڵ㡣

A package can be an entrypoint in some contexts and not in others. Lets say your app uses a library package A. When you run your app, A is not the entrypoint package. However, if you go over to A and execute its tests, in that context, it is the entrypoint since your app isn��t involved.
����ĳЩ�����п�����Ϊ��ڵ������һЩ�����в��ǡ�������˵��ĳ���ʹ���˿�A������������ĳ���ʱ��A��������ڵ㡣��Ȼ��ˣ������ʹ�� A ��ִ������ԣ�����������£�����Ȼ����ڵ�; ��Ϊ����Ӧ�ó��򲢲��漰A��

Entrypoint directory  ��ڵ�Ŀ¼

A directory inside your package that is allowed to contain Dart entrypoints.
��ĳ�������Ŀ¼������Dart��ڵ㡣

Pub has a whitelist of these directories: benchmark, bin, example, test, tool, and web. Any subdirectories of those (except bin) may also contain entrypoints.
Pub������ЩĿ¼�İ�������benchmark, bin, example, test, tool, and web.�κ���Щ����Ŀ¼ (���� bin) Ҳ�ܰ�����ڵ㡣

Immediate dependency ֱ�ӵ������
A dependency that your package directly uses itself. The dependencies you list in your pubspec are your package��s immediate dependencies. All other dependencies are transitive dependencies.
��İ�ֱ��ʹ���Լ��������������� pubspec ���г���������ϵ����İ�ֱ���������������������ϵ�ǿɴ��ݵ������

Library package ���

A package that other packages will depend on. Library packages may have dependencies on other packages and may be dependencies themselves. They may also include scripts that will be run directly. The opposite of a library package is an application package.
ȡ�����������İ��������������������������������ܻ������Լ������ǻ����ܰ���ֱ�����еĽű�����֮�෴����Ӧ�ó������

Library packages should not check their lockfile into source control, since they should support a range of dependency versions. Their immediate dependencies�� version constraints should be as wide as possible while still ensuring that the dependencies will be compatible with the versions that were tested against.
�����Ӧ����ֹ���ǵ��ļ�����Դ���ƣ���������Ϊ����Ӧ��֧�ֺܴ�Χ�Ķ����԰汾�����ǵ�ֱ��������ϵ�汾Լ��Ӧ�þ����Ĺ�����ͬʱҪȷ����Щ������������˲��Թ��İ汾���ݡ�

Since semantic versioning requires that libraries increment their major version numbers for any backwards incompatible changes, library packages will usually require their dependencies�� versions to be greater than or equal to the versions that were tested and less than the next major version. So if your library depended on the (fictional) transmogrify package and you tested it at version 1.2.1, your version constraint would be ^1.2.1.
��������汾Ҫ��������κ�֮����ݵĸı�����Ҫ�汾�ţ����ͨ����Ҫ���ǵ�������ϵ�İ汾Ҫ���ڻ���ڱ����Եİ汾��С����һ����Ҫ�汾����ˣ�������Ŀ����� (�鹹��) ���ϰ������� 1.2.1 �����������汾Լ��Ӧ���� ^1.2.1��

Lockfile �ļ�

A file named pubspec.lock that specifies the concrete versions and other identifying information for every immediate and transitive dependency a package relies on.
һ����Ϊpubspec.lock���ļ�ָ���˾���İ汾�������й�ÿһ��ֱ�ӺͿɴ��ݵ��������������ı�ʶ��Ϣ��

Unlike the pubspec, which only lists immediate dependencies and allows version ranges, the lock file comprehensively pins down the entire dependency graph to specific versions of packages. A lockfile ensures that you can recreate the exact configuration of packages used by an application.
���� pubspec����ֻ�г���ֱ�������������İ汾��Χ��Lockfile�ļ�ȫ�������������������ϵͼ���ض��汾��һ��lockfile�ļ�����ȷ�����������´���Ӧ�ó�����ʹ�õİ���ȷ�����ݡ�

The lockfile is generated automatically for you by pub when you run pub get, pub upgrade, or pub downgrade.. If your package is an application package, you will typically check this into source control. For library packages, you usually won��t.
lockfile����������Pub get��pubupgrade������pub downgradeʱpubΪ���Զ������ġ������İ���һ��Ӧ�ó��������ͨ�������Դ���������lockfile�����ڿ������ͨ�����ᡣ

SDK constraint Լ��

The declared versions of the Dart SDK itself that a package declares that it supports. An SDK constraint is specified using normal version constraint syntax, but in a special environment section in the pubspec.
SDK�����İ汾�������Լ��İ���֧�ֵİ汾��SDK Լ����Ҫʹ�������汾��Լ���﷨���������⻷��������Ϊpubspec��һ���֡�

Source ��Դ

A kind of place that pub can get packages from. A source isn��t a specific place like pub.dartlang.org or some specific Git URL. Each source describes a general procedure for accessing a package in some way. For example, git is one source. The git source knows how to download packages given a Git URL. Several different supported sources are available.
Pub���Դ�Source��õ��������sorce������pub.dartlang.org����������Git URLһ����һ������ĵط���ÿһ����Դ����һ������ĳ���������һ����̡��ٸ����ӣ�git����һ����Դ��git��Դ֪����δ�һ��Git URL�����س������������֧ͬ�ֵ���Դ�ǿ��õġ�