# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/freewrl/freewrl-1.06.ebuild,v 1.4 2004/08/01 07:02:27 mr_bones_ Exp $

inherit nsplugins eutils

IUSE="opengl"

MY_P="FreeWRL-${PV}"
DESCRIPTION="VRML2 and X3D compliant browser"
SRC_URI="http://193.1.219.87/sourceforge/freewrl/${MY_P}.tar.gz"
HOMEPAGE="http://freewrl.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${MY_P}"

DEPEND="virtual/x11
	virtual/jdk
	>=dev-java/saxon-bin-7.5
	>=dev-lang/perl-5.8.2
	>=dev-perl/Digest-MD5-2.09
	>=dev-perl/HTML-Parser-2.25
	>=dev-perl/MIME-Base64-2.11
	>=dev-perl/URI-1.04
	>=dev-perl/libnet-1.0607
	>=dev-perl/libwww-perl-5.47
	opengl? ( virtual/opengl virtual/glut )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/FreeWRL-1.06+gentoo_pd.diff
}

src_compile() {

	perl Makefile.PL
	make all || die "make failed"
}

src_install() {
	dolib JS/js/src/Linux_All_OPT.OBJ/libjs.so
	dolib blib/arch/auto/VRML/VRMLFunc/libFreeWRLFunc.so

	make DESTDIR=${D} install || die "make install failed"
	dobin CFrontEnd/freewrl
	dobin CFrontEnd/fw2init.pl
	local dest="/opt/netscape/plugins"
	dodir $dest
	cp -a `find Plugin -name npfreewrl.so` ${D}/$dest/
	cp -a `find java -name vrml.jar` ${D}/$dest/
	inst_plugin ${D}/$dest/npfreewrl.so
	inst_plugin ${D}/$dest/vrml.jar
	dohtml README.html
	dodoc tests

	insinto /usr/lib/perl5/5.8.2/VRML/fonts
	doins fonts/*
	insinto /usr/lib/perl5/5.8.2/VRML/x3d
	doins x3d/*
}
