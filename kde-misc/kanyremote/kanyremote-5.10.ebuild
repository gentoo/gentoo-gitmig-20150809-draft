# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kanyremote/kanyremote-5.10.ebuild,v 1.4 2010/04/22 17:46:50 hwoarang Exp $

EAPI="2"
PYTHON_DEPEND="2"

inherit python base

DESCRIPTION="KDE frontend to Anyremote"
HOMEPAGE="http://anyremote.sourceforge.net/"
SRC_URI="mirror://sourceforge/anyremote/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth"

DEPEND=">=app-mobilephone/anyremote-4.4[bluetooth?]
	 dev-python/PyQt4[X]
	 kde-base/pykde4
	 bluetooth? ( dev-python/pybluez )"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	#fix documentation directory wrt bug #316087
	sed -i "s/doc\/${PN}/doc\/${PF}/g" Makefile.am
	eautoreconf
	# workaround to bluetooth check when bluetooth use flag is disabled
	! use bluetooth && epatch "${FILESDIR}/disable_bluetooth.patch"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
