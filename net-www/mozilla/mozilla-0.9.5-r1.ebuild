# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@cvs.gentoo.org>
# Author Achim Gottinger <achim@gentoo.org>

S=${WORKDIR}/mozilla
DESCRIPTION="The Mozilla web browser"

# NOTE!!  Please use the .tar.bz2 next time, as it is about 10mb smaller.
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/mozilla${PV}/src/${PN}-source-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.org"

PROVIDE="virtual/x11-web-browser"

RDEPEND=">=gnome-base/ORBit-0.5.10-r1
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip
	mozqt? ( x11-libs/qt-x11 )"

DEPEND="${RDEPEND}
	sys-devel/perl"


src_compile() {

	chown -R root.root *

	if [ "`use mozqt`" ] ; then
		myconf="--with-qt --enable-toolkit=qt --without-gtk"
	else
		myconf="--with-gtk --enable-toolkit=gtk"
	fi

	if [ -z "$DEBUG" ] ; then
		myconf="${myconf} --enable-strip-libs"
	fi

	export BUILD_MODULES=all

	./configure  --host=${CHOST}					\
		     --prefix=/usr/lib/mozilla 				\
		     --disable-tests		 			\
		     --disable-debug					\
		     --disable-dtd-debug				\
		     --disable-pedantic					\
		     --enable-xsl					\
		     --enable-crypto					\
		     --enable-detect-webshell-leaks			\
		     --with-java-supplement				\
		     --with-extensions=default				\
		     --enable-optimize=-O2				\
		     --with-default-mozilla-five-home=/usr/lib/mozilla	\
		     ${myconf} || die

	make depend || die
	make || die
}

src_install() {

	dodir /usr/lib/mozilla/include
	cd ${S}/dist/include
	cp -LfR * ${D}/usr/lib/mozilla/include
#	rm ${D}/usr/lib/mozilla/include/*.h
	
#	cd ${S}/include
#	cp -f *.h ${D}/usr/lib/mozilla/include
#	cp -f nspr/*.h ${D}/usr/lib/mozilla/include/nspr
#	cp -f nspr/obsolete/*.h ${D}/usr/lib/mozilla/include/nspr/obsolete
#	cp -f nspr/private/*.h ${D}/usr/lib/mozilla/include/nspr/private
#	cp -f nspr/md/*.cfg ${D}/usr/lib/mozilla/include/nspr/md

	export MOZILLA_OFFICIAL=1
	export BUILD_OFFICIAL=1
	cd ${S}/xpinstall/packager
	make || die
	dodir /usr/lib

	tar xzf ${S}/dist/mozilla-`uname -m`-pc-linux-gnu.tar.gz 	\
	    -C ${D}/usr/lib

#	mv ${D}/usr/lib/package ${D}/usr/lib/mozilla
	exeinto /usr/bin
	doexe ${FILESDIR}/mozilla
	insinto /etc/env.d
	doins ${FILESDIR}/10mozilla
	dodoc LEGAL LICENSE README/mozilla/README*

	# Take care of non root execution
	# (seems the problem is that not all files are readible by the user)
	chmod -R g+r,o+r ${D}/usr/lib/mozilla

        # Install icon and .desktop for menu entry
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		doins ${S}/build/package/rpm/SOURCES/mozilla-icon.png
		insinto /usr/share/gnome/apps/Internet
		doins ${S}/build/package/rpm/SOURCES/mozilla.desktop
        fi

	# Fix to get it removed at unmerge
	touch ${D}/usr/lib/mozilla/component.reg
}

pkg_postinst () {

	# Take care of component registration
	export MOZILLA_FIVE_HOME="/usr/lib/mozilla"

	# Needed to update the run time bindings for REGXPCOM 
	# (do not remove next line!)
	env-update
	# Register components, setup Chrome .rdf files and fix file permissions
	/usr/lib/mozilla/regxpcom
	chmod g+r,o+r /usr/lib/mozilla/component.reg
	/usr/lib/mozilla/regchrome
	find /usr/lib/mozilla -type d -perm 0700 -exec chmod 755 {} \; || :

    
	echo
	echo "*****************************************************************"
	echo "* NB:  Please unmerge old versions prior to 0.9.5 as the header *"
	echo "* layout in /usr/lib/mozilla/include have changed and will      *"
	echo "* result in compile errors when compiling programs that need    *"
	echo "* mozilla headers and libs (galeon, nautilus, ...)              *"
	echo "*****************************************************************"
	echo
}

