# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/pisg/pisg-0.67.ebuild,v 1.1 2005/08/19 15:28:54 swegener Exp $

DESCRIPTION="Perl IRC Statistics Generator"
HOMEPAGE="http://pisg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Text-Iconv"
DEPEND="dev-lang/perl
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's!lang\.txt!/usr/share/pisg/lang.txt!' \
		-e 's!layout/!/usr/share/pisg/layout/!' \
		modules/Pisg.pm \
		|| die "sed failed"
}

src_install () {
	eval $(perl -V:installvendorlib)

	dobin pisg || die "dobin failed"

	insinto "${installvendorlib}"
	doins -r modules/. || die "doins failed"

	insinto /usr/share/pisg
	doins -r gfx layout lang.txt || die "doins failed"

	dodoc \
		docs/{CREDITS,Changelog,FORMATS,pisg-doc.txt} \
		docs/dev/API pisg.cfg README || die "dodoc failed"
	doman docs/pisg.1 || die "doman failed"
	dohtml docs/pisg-doc.html || die "dohtml failed"
}

pkg_postinst() {
	einfo
	einfo "The pisg images have been installed in /usr/share/pisg/gfx"
	einfo
}
