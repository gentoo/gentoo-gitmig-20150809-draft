# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conky/conky-1.0.ebuild,v 1.1 2005/06/22 11:26:48 dragonheart Exp $

inherit eutils

DESCRIPTION="minimalist system monitor for X based on torsmo"
HOMEPAGE="http://conky.rty.ca"
SRC_URI="http://conky.rty.ca/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="truetype seti"

RDEPEND="virtual/libc
	virtual/x11
	truetype? ( >=media-libs/freetype-2 )
	seti? ( sci-astronomy/setiathome )"

DEPEND="truetype? ( >=media-libs/freetype-2 )
	virtual/x11
	>=sys-devel/automake-1.4
	sys-devel/autoconf
	sys-apps/grep
	sys-apps/sed
	sys-devel/gcc"


src_compile() {
	econf \
	   `use_enable truetype xft` \
	   `use_enable seti` || die "econf failed"
	emake || die "compile failed"
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog AUTHORS README conkyrc.sample
}

pkg_postinst() {
	einfo 'default configuration file is "~/.conkyrc"'
	einfo "you can find a sample configuration file in"
	einfo "/usr/share/doc/${PF}/conkyrc.sample.gz"
	einfo
	einfo "Comment out temperature info lines if you have no kernel"
	einfo "support for it."
	einfo
	ewarn "Conky doesn't work with window managers that"
	ewarn "take control over root window such as Gnome's nautilus."
}
