# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/libupnp/libupnp-1.4.0.ebuild,v 1.1 2006/07/01 18:38:25 genstef Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An Portable Open Source UPnP Development Kit"
HOMEPAGE="http://www.virtualworlds.de/upnp/"
SRC_URI="mirror://sourceforge/pupnp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND="${RDEPEND}"
RDEPEND="!net-misc/upnp
		sys-fs/e2fsprogs"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix compile problems on amd64
	epatch ${FILESDIR}/${P}-va_list.patch
}

src_compile() {
	# w/o docdir to avoid sandbox violations	
	econf \
		$(use_enable debug) \
		--without-docdir || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	
	dodoc LICENSE NEWS README ChangeLog
	dohtml upnp/doc/*.pdf
}

