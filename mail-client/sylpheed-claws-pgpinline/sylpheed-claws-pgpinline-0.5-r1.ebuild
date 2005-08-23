# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-pgpinline/sylpheed-claws-pgpinline-0.5-r1.ebuild,v 1.6 2005/08/23 14:34:27 genone Exp $

inherit eutils

MY_P="${P##sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to support mails with inline pgp signatures"
HOMEPAGE="http://sylpheed-claws.sourceforge.net"
SRC_URI="http://colin.pclinux.fr/${PN%%-pgpinline}-gtk2-${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-1.9.12
		=app-crypt/gpgme-0.3.14-r1
		!>=mail-client/sylpheed-claws-1.9.13"	# included in main package

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/glib2-buildfix.patch
}

src_compile() {
	export GPGME_CONFIG=${ROOT}/usr/bin/gpgme3-config

	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
