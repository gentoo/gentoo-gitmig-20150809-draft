# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wput/wput-0.6.ebuild,v 1.3 2008/03/14 09:29:51 phreak Exp $

inherit eutils

DESCRIPTION="A tiny, wget-alike program, that is designed to upload files/whole directories to remote ftp-servers"
HOMEPAGE="http://wput.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="debug"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	# Fix bug 126828
	epatch "${FILESDIR}/wput-0.6-respectldflags.patch"
}

src_compile() {
	local myconf
	use debug && myconf="--enable-memdbg=yes" || myconf="--enable-g-switch=no"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog INSTALL TODO
}
