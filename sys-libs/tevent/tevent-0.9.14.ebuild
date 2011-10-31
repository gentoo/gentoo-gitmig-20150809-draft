# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/tevent/tevent-0.9.14.ebuild,v 1.2 2011/10/31 16:02:11 vostorga Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit waf-utils python

DESCRIPTION="Samba tevent library"
HOMEPAGE="http://tevent.samba.org/"
SRC_URI="http://samba.org/ftp/tevent/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/python-2.4.2
	>=sys-libs/talloc-2.0.6[python]"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

WAF_BINARY="${S}/buildtools/bin/waf"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
