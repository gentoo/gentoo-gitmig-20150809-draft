# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-smime/claws-mail-smime-0.5.8.ebuild,v 1.4 2007/06/28 10:26:54 ticho Exp $

inherit eutils

MY_P="${P#claws-mail-}"

DESCRIPTION="This plugin allows you to handle S/MIME signed and/or encrypted mails."
HOMEPAGE="http://www.claws-mail.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/claws-mail-2.7.0
		>=app-crypt/gpgme-1.1.1"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# we have to make sure that pinentry has gtk support
	if ! built_with_use --missing true -o app-crypt/pinentry gtk qt3; then
		eerror "You need to merge app-crypt/pinentry with USE=gtk or USE=qt3"
		eerror "for working GPG support. You have the following options:"
		eerror " - remerge app-crypt/pinentry with USE=gtk"
		eerror " - remerge app-crypt/pinentry with USE=qt3"
		die "missing gtk/qt support in app-crypt/pinentry"
	fi
}

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/claws-mail/plugins/*.{a,la}
}
