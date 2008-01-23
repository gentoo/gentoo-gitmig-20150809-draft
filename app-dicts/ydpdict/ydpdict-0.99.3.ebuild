# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ydpdict/ydpdict-0.99.3.ebuild,v 1.1 2008/01/23 20:22:25 peper Exp $

DESCRIPTION="Interface for the Collins Dictionary."
HOMEPAGE="http://toxygen.net/ydpdict/"
SRC_URI="http://toxygen.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao"

RDEPEND="=app-dicts/libydpdict-${PV}*
	ao? ( media-libs/libao )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0"

src_compile() {
	econf \
		$(use_with ao libao) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	dodir "/etc"
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README
}

pkg_postinst() {
	echo
	elog "Note that to use this program you'll need the original Collins Dictionary"
	elog "datafiles (dict100.*, dict101.*). These can be found in the Dabasase/"
	elog "directory of the Windows version of the Collins dictionary. Once you obtain"
	elog "the files, put them into /usr/share/ydpdict"
	elog
	elog "Some configuration options can be set in /etc/ydpdict.conf"
	echo
}
