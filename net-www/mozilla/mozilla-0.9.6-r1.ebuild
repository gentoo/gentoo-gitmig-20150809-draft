# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.9.6.ebuild,v 1.4 2001/11/23 04:45:07 azarah Exp

S=${WORKDIR}/mozilla
DESCRIPTION="The Mozilla web browser"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/mozilla${PV}/src/${PN}-source-${PV}.tar.bz2"
HOMEPAGE="http://www.mozilla.org"

PROVIDE="virtual/x11-web-browser"

RDEPEND=">=gnome-base/ORBit-0.5.10-r1
	>=dev-libs/glib-1.2.10
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip
	mozqt? ( x11-libs/qt-x11 )"

DEPEND="${RDEPEND}
	sys-devel/perl"


# needed by src_compile() and src_install()
export MOZILLA_OFFICIAL=1
export BUILD_OFFICIAL=1	

src_compile() {

	chown -R root.root *

	local myconf
	if [ "`use mozqt`" ] ; then
		myconf="--with-qt --enable-toolkit=qt --without-gtk"
	else
		myconf="--with-gtk --enable-toolkit=gtk"
	fi

	if [ -z "$DEBUG" ] ; then
		myconf="${myconf} --enable-strip-libs"
	fi


	# NB!!:  Due to the fact that the non default modules do not always
	#        compile properly, using them is considered unsupported, and
	#        is just here for completeness.  Please do not use if you 
	#        do not know what you are doing!
	#
	# The defaults are (as of 0.9.6, according to configure (line ~9787)):
	#     cookie wallet content-packs xml-rpc xmlextras help transformiix venkman
	# Non-defaults are:
	#     irc xmlterm inspector access-builtin ctl
	local myext="default"
	if [ "`use mozirc`" ] ; then
		myext="${myext},irc"
	fi
	if [ "`use mozxmlterm`" ] ; then
		myext="${myext},xmlterm"
	fi
	if [ "`use mozinspector`" ] ; then
		myext="${myext},inspector"
	fi
	if [ "`use mozaccess-builtin`" ] ; then
		myext="${myext},access-builtin"
	fi
	if [ "`use mozctl`" ] ; then
		myext="${myext},ctl"
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
		     --with-extensions="${myext}"			\
		     --enable-optimize=-O3				\
		     --with-default-mozilla-five-home=/usr/lib/mozilla	\
		     ${myconf} || die

	make depend || die
	make || die
}

src_install() {

	dodir /usr/lib/mozilla/include
	cd ${S}/dist/include
	cp -LfR * ${D}/usr/lib/mozilla/include

	cd ${S}/xpinstall/packager
	make || die
	dodir /usr/lib

	tar xzf ${S}/dist/mozilla-`uname -m`-pc-linux-gnu.tar.gz 	\
	    -C ${D}/usr/lib

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

