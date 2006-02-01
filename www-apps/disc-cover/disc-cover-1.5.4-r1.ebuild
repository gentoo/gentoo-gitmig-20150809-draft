# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/disc-cover/disc-cover-1.5.4-r1.ebuild,v 1.5 2006/02/01 10:35:07 blubb Exp $

inherit webapp

DESCRIPTION="A web frontend to disc-cover."
HOMEPAGE="http://www.vanhemert.co.uk/disc-cover.html"
SRC_URI="http://www.vanhemert.co.uk/files/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

DEPEND="=app-cdr/disc-cover-${PVR}"

src_unpack() {
	unpack ${A}

	sed -e "s,\\./disc-cover,disc-cover,g
		s,\"disc-cover\",\"/usr/bin/disc-cover\",
		s,\"templates\",\"/usr/share/disc-cover/templates\",
		s,templates/\$template,/usr/share/disc-cover/templates/\$template," -i ${S}/index.cgi || die

	sed -e "s|\\./disc-cover|disc-cover|
		s|\!\ -f\ \"disc-cover\"\ or\ ||
		s|\"\$picture\"|\"/usr/share/disc-cover/\"\.\"\$picture\"|" -i ${S}/online.cgi || die
}

src_install() {
	webapp_src_preinst

	exeinto ${MY_CGIBINDIR}
	doexe index.cgi online.cgi

	insinto /usr/share/${PN}/
	doins busy.png offline.png online.png

	for lang in en; do
		webapp_postinst_txt ${lang} ${FILESDIR}/postinst-${lang}.txt
	done

	webapp_src_install
}
