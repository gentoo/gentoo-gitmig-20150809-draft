# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winex-cvs/winex-cvs-3.0.ebuild,v 1.1 2003/04/17 13:42:53 mholzer Exp $

IUSE="cups opengl"

inherit eutils

# Dont modify the ECVS_BRANCH setting yourself.
# Instead, make a backup of this ebuild and rename it to
# winex-[your branch].ebuild. 
#
# Example:
#   winex-kohan-2.1.ebuild
#
# You can find more branches on 
# http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/winex/wine/


ECVS_SERVER="cvs.winex.sourceforge.net:/cvsroot/winex"
ECVS_MODULE="wine"
ECVS_BRANCH=${PN/cvs/}${PV//./-}
ECVS_BRANCH=${ECVS_BRANCH/pre/pre-}
ECVS_BRANCH=${ECVS_BRANCH/_/-}
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${ECVS_BRANCH}"

inherit cvs

S=${WORKDIR}/${ECVS_MODULE}
#echo ${ECVS_BRANCH}
	

DESCRIPTION="WineX is a distribution of Wine with enhanced DirectX for gaming.
	     This ebuild will fetch the newest cvs sources from the cvs-server."
HOMEPAGE="http://www.transgaming.com/"

SLOT="0"
KEYWORDS="x86 -ppc"
LICENSE="Aladdin"

newdepend "sys-devel/gcc
	sys-devel/flex
	dev-util/yacc
	>=media-libs/freetype-2.0.0
	X? ( 	virtual/x11 
		dev-lang/tcl 
		dev-lang/tk ) 
	opengl? ( virtual/opengl )
	cups? ( net-print/cups )"

src_compile() {
	cd ${S}
	local myconf

	use opengl && myconf="--enable-opengl" || myconf="--disable-opengl"
	[ -z $DEBUG ] && myconf="$myconf --disable-trace --disable-debug" || myconf="$myconf --enable-trace --enable-debug"

	# patching winex to not compile wcmd
	epatch ${FILESDIR}/winex-cvs-3.0_pre1.patch

	# the folks at #winehq were really angry about custom optimization
	unset CFLAGS
	unset CXXFLAGS
	
	./configure --prefix=/usr/lib/winex-cvs \
		--sysconfdir=/etc/winex-cvs \
		--host=${CHOST} \
		--enable-curses \
		--with-x \
		${myconf} || die "configure failed"

	# Fixes a winetest issue
	cd ${S}/programs/winetest
	cp Makefile 1
	sed -e 's:wine.pm:include/wine.pm:' 1 > Makefile

	# This persuades wineshelllink that "winex-cvs" is a better loader :)
	cd ${S}/tools
	cp wineshelllink 1
	sed -e 's/\(WINE_LOADER=\)\(\${WINE_LOADER:-wine}\)/\1winex-cvs/' 1 > wineshelllink

	cd ${S}	
	make depend all || die "make depend all failed"
	cd programs && gmake || die "emake died"
}

src_install () {
	local WINEXMAKEOPTS="prefix=${D}/usr/lib/winex-cvs"
	
	# Installs winex to /usr/lib/winex-cvs
	cd ${S}
	make ${WINEXMAKEOPTS} install || die "make install failed"
	cd ${S}/programs
	make ${WINEXMAKEOPTS} install || die "make install failed"
	

	# Creates /usr/lib/winex-cvs/.data with fake_windows in it
	# This is needed for our new winex-cvs wrapper script
	dodir /usr/lib/winex-cvs/.data
	pushd ${D}/usr/lib/winex-cvs/.data
	tar jxvf ${FILESDIR}/${PN}-fake_windows.tar.bz2 
	popd
	cp ${S}/documentation/samples/config ${S}/documentation/samples/config.orig
	sed -e 's/.transgaming\/c_drive/.winex-cvs\/fake_windows/' \
	    ${S}/documentation/samples/config.orig > ${S}/documentation/samples/config
	cp ${S}/documentation/samples/config ${D}/usr/lib/winex-cvs/.data/config
	cp ${WORKDIR}/wine/winedefault.reg ${D}/usr/lib/winex-cvs/.data/winedefault.reg
	# Install the wrapper script
	dodir /usr/bin
	cp ${FILESDIR}/${PN}-winex ${D}/usr/bin/winex-cvs
	cp ${FILESDIR}/${PN}-regedit ${D}/usr/bin/regedit-winex-cvs

	# Take care of the other stuff
	cd ${S}
	dodoc ANNOUNCE AUTHORS BUGS ChangeLog DEVELOPERS-HINTS LICENSE README

	insinto /usr/lib/winex-cvs/.data/fake_windows/Windows
	doins documentation/samples/system.ini
	doins documentation/samples/generic.ppd
	
	# Manpage setup
	cp ${D}/usr/lib/${PN}/man/man1/wine.1 ${D}/usr/lib/${PN}/man/man1/${PN}.1
	doman ${D}/usr/lib/${PN}/man/man1/${PN}.1
	rm ${D}/usr/lib/${PN}/man/man1/${PN}.1

	# Remove the executable flag from those libraries.
	cd ${D}/usr/lib/winex-cvs/bin
	chmod a-x *.so
		
}

pkg_postinst() {
	einfo "Use /usr/bin/winex-cvs to start winex."
	einfo "This is a wrapper-script which will take care of everything"
	einfo "else. If you have further questions, enhancements or patches"
	einfo "send an email to phoenix@gentoo.org"
	einfo ""
	einfo "Manpage has been installed to the system."
	einfo "\"man winex-cvs\" should show it."
}

