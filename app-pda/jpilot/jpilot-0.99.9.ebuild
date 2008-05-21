# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot/jpilot-0.99.9.ebuild,v 1.6 2008/05/21 12:44:39 drac Exp $

inherit eutils multilib

DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
HOMEPAGE="http://jpilot.org/"
SRC_URI="http://jpilot.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="nls"

RDEPEND=">=app-pda/pilot-link-0.11.8
	>=x11-libs/gtk+-2.6.10-r1"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-perl/XML-Parser-2.34
	>=dev-util/pkgconfig-0.22"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fixes bug 93471.
	epatch "${FILESDIR}/${P}-keyring-cats.patch"

	# There are four icons available.  Use the third.
	sed -i -e 's/jpilot.xpm/jpilot-icon3.xpm/' jpilot.desktop || die "sed'ing the desktop file failed"
}

src_compile() {
	econf $(use_enable nls) || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" \
		libdir=/usr/$(get_libdir)/jpilot/plugins \
		docdir=/usr/share/doc/${PF} \
		icondir=/usr/share/pixmaps \
		desktopdir=/usr/share/applications || die "install failed"

	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README TODO || die "installing docs failed"
	doman docs/*.1

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins "${S}"/jpilotrc.*
}

pkg_postinst() {
	elog
	elog "The jpilot-syncmal plugin has moved to its own ebuild."
	elog "If you want to use that plugin, please run"
	elog "    emerge jpilot-syncmal"
	elog
	elog "There are other plugins available as well.  To see the"
	elog "list, please run"
	elog "    emerge -s jpilot"
	elog
}
