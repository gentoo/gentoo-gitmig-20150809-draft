# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ekg2/ekg2-20041104.ebuild,v 1.2 2004/11/18 19:30:29 sekretarz Exp $

DESCRIPTION="Text based Instant Messenger client that supports many protocols like Jabber and Gadu-Gadu"
HOMEPAGE="http://www.ekg2.org/"
SRC_URI="http://www.ekg2.org/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~ppc ~amd64"

IUSE="gpm ssl spell jpeg nogg gsm"

DEPEND=">=dev-libs/expat-1.95.6
	>=net-libs/gnutls-1.0.17
	gpm? ( >=sys-libs/gpm-1.20.1 )
	ssl? ( >=dev-libs/openssl-0.9.6m )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	spell? ( >=app-text/aspell-0.50.5 )
	!nogg? ( >=net-libs/libgadu-20040820 )
	gsm? ( >=media-sound/gsm-1.0.10 )"

#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {

	econf \
	    --with-pthread \
	    `use_with !nogg libgadu` \
	    `use_with gpm gpm-mouse` \
	    `use_with ssl openssl` \
	    `use_with jpeg libjpeg` \
	    `use_with spell aspell` \
	    `use_with gsm libgsm` \
	     || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# Install plugins into proper directory
	if use amd64; then
		CONF_LIBDIR=/usr/lib/ekg2/plugins
	fi

	einstall || die
	dodoc docs/*
}
