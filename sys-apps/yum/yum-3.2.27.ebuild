# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/yum/yum-3.2.27.ebuild,v 1.1 2010/03/19 13:20:39 deathwing00 Exp $

EAPI=2
NEED_PYTHON=1
inherit python eutils multilib

DESCRIPTION="automatic updater and package installer/remover for rpm systems"
HOMEPAGE="http://yum.baseurl.org/"
SRC_URI="http://yum.baseurl.org//download/${PV:0:3}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5[sqlite]
	app-arch/rpm[python]
	dev-python/sqlitecachec
	dev-python/celementtree
	dev-libs/libxml2[python]
	dev-python/urlgrabber"

src_install() {
	python_version
	emake install DESTDIR="${D}" || die
	rm -r "${D}"/etc/rc.d || die
	find "${D}" -name '*.py[co]' -print0 | xargs -0 rm -f
}

pkg_postinst() {
	python_version
	python_mod_optimize \
		/usr/$(get_libdir)/python${PYVER}/site-packages/{yum,rpmUtils} \
		/usr/share/yum-cli
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/{yum,rpmUtils} /usr/share/yum-cli
}
