# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fwbuilder/fwbuilder-4.0.1-r1.ebuild,v 1.1 2010/09/13 06:28:01 kumba Exp $

EAPI="2"

inherit eutils qt4-r2 multilib autotools

DESCRIPTION="A firewall GUI"
HOMEPAGE="http://www.fwbuilder.org/"
SRC_URI="mirror://sourceforge/fwbuilder/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""
#IUSE="+pch"

DEPEND="~net-libs/libfwbuilder-${PV}
	>=x11-libs/qt-gui-4.3
	dev-libs/openssl
	dev-libs/elfutils
	sys-devel/gnuconfig
	"
RDEPEND="${DEPEND}"

src_prepare() {
	qt4-r2_src_prepare
	epatch "${FILESDIR}/4.x-qmake-use-LDFLAGS.patch"
	eautoreconf || die "eautoreconf failed"

	# This package fundamentally changed its build system.  We have to
	# manually copy config.{sub,guess} from /usr/share/gnuconfig/.
	cp /usr/share/gnuconfig/config.{sub,guess} "${WORKDIR}/${P}/"	\
		|| die "failed to copy config.{sub,guess}"
}

src_configure() {
	econf || die "econf failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
}

pkg_postinst() {
	validate_desktop_entries

	elog "You need to emerge sys-apps/iproute2 on the machine"
	elog "that will run the firewall script."
}
