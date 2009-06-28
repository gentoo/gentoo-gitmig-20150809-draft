# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.9.33.ebuild,v 1.2 2009/06/28 13:58:52 maekke Exp $

EAPI="2"

NEED_PYTHON="2.4"

inherit distutils multilib twisted

MY_P="Nevow-${PV}"

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow"
SRC_URI="http://divmod.org/trac/attachment/wiki/SoftwareReleases/${MY_P}.tar.gz?format=raw -> ${MY_P}.tar.gz"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND=">=dev-python/twisted-2.5
	>=dev-python/twisted-web-8.1.0
	net-zope/zopeinterface"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="nevow formless"

src_install() {
	export PORTAGE_PLUGINCACHE_NOOP=1
	distutils_src_install
	# mantissa expects js to be under site-packages/
	# but setup.py doesn't install it
	insinto "$(python_get_sitedir)/${PN}"
	doins ${PN}/*.js || die "doins failed"
	doins -r ${PN}/js || die "doins failed"

	doman doc/man/nevow-xmlgettext.1
	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/{howto,html,old} examples
	fi
	rm -fr "${D}usr/doc"
	find "${D}" -name ".svn" -print0 | xargs -0 rm -fr

	unset PORTAGE_PLUGINCACHE_NOOP
}

src_test() {
	PYTHONPATH="." trial nevow || die "nevow trial failed"
	PYTHONPATH="." trial formless || die "formless trial failed"
}

update_nevow_plugin_cache() {
	einfo "Updating nevow plugin cache..."
	python -c 'from twisted.plugin import IPlugin, getPlugIns;from nevow import plugins; list(getPlugIns(IPlugin, plugins))'
}

pkg_postrm() {
	twisted_pkg_postrm
	update_nevow_plugin_cache
}

pkg_postinst() {
	twisted_pkg_postinst
	update_nevow_plugin_cache
}
