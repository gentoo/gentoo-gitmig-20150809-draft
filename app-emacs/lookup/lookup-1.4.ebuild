# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lookup/lookup-1.4.ebuild,v 1.1 2004/02/13 18:17:28 usata Exp $

inherit elisp

IUSE=""

DESCRIPTION="An interface to search CD-ROM books and network dictionaries"
HOMEPAGE="http://openlab.jp/edict/lookup/"
SRC_URI="http://openlab.jp/edict/lookup/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/emacs"

S="${WORKDIR}/${P}"

src_compile() {

	econf || die
	make || die
}

src_install() {

	einstall lispdir=${D}${SITELISP}/${PN} || die

	elisp-site-file-install ${FILESDIR}/50lookup-gentoo.el

	if ! $(grep 2010/tcp /etc/services >/dev/null 2>&1) ; then
		cp /etc/services ${T}/services
		cat >>${T}/services<<-EOF
		ndtp		2010/tcp			# Network Dictionary Transfer Protocol
		EOF
		insinto /etc
		doins ${T}/services
	fi

	dodoc AUTHORS ChangeLog NEWS README VERSION
}
