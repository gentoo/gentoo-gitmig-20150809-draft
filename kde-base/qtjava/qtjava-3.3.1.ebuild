# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtjava/qtjava-3.3.1.ebuild,v 1.1 2004/11/06 17:23:33 danarmak Exp $

KMNAME=kdebindings
inherit kde-meta

DESCRIPTION="Java bindings for QT"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/jdk"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

myconf="$myconf --with-java=`java-config --jdk-home`"

# Doesn't really need kde, only kde? But then, it installs by default into $KDEDIR/...

# Someone who's into java should look over this...

src_install() {
    kde-meta_src_install

    mkdir -p $D/usr/share/qtjava
    cat > $D/usr/share/qtjava/package.env << EOF
DESCRIPTION=Java bindings for QT
CLASSPATH=:$PREFIX/lib/java/qtjava.jar:
EOF
}
