# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/libupnp/libupnp-1.4.1.ebuild,v 1.1 2006/09/29 19:15:33 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An Portable Open Source UPnP Development Kit"
HOMEPAGE="http://pupnp.sourceforge.net/"
SRC_URI="mirror://sourceforge/pupnp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="!net-misc/upnp"

src_compile() {
	# w/o docdir to avoid sandbox violations	
	econf \
		$(use_enable debug) \
		--without-docdir \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin upnp/upnp_tv_ctrlpt upnp/upnp_tv_device || die
	dodoc NEWS README ChangeLog
	dohtml upnp/doc/*.pdf
}

