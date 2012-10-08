# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-gpg/pidgin-gpg-0.9.ebuild,v 1.2 2012/10/08 18:37:17 pinkbyte Exp $

EAPI=4

DESCRIPTION="Pidgin GPG/OpenPGP (XEP-0027) plugin"
HOMEPAGE="https://github.com/segler-alex/Pidgin-GPG"
SRC_URI="https://github.com/downloads/segler-alex/Pidgin-GPG/pidgin-gpg-0.9.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-crypt/gpgme
	net-im/pidgin"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
