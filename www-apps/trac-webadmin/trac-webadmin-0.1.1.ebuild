# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac-webadmin/trac-webadmin-0.1.1.ebuild,v 1.1 2006/03/18 12:19:09 dju Exp $

inherit distutils

DESCRIPTION="A Trac plugin for administering Trac projects through the web interface."
HOMEPAGE="http://projects.edgewall.com/trac/wiki/WebAdmin"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="trac"
KEYWORDS="~x86"
IUSE=""

SLOT="0"

DEPEND=">=www-apps/trac-0.9.3
	>=dev-python/setuptools-0.6_alpha10"

# from marienz's setuptools.eclass:
src_install() {
	${python} setup.py install --root=${D} --no-compile \
		--single-version-externally-managed "$@" || die

	DDOCS="CHANGELOG COPYRIGHT KNOWN_BUGS MAINTAINERS PKG-INFO"
	DDOCS="${DDOCS} CONTRIBUTORS TODO"
	DDOCS="${DDOCS} Change* MANIFEST* README*"

	for doc in ${DDOCS}; do
		[ -s "$doc" ] && dodoc $doc
	done

	[ -n "${DOCS}" ] && dodoc ${DOCS}
}

src_test() {
	"${python}" setup.py test || die "tests failed"
}

pkg_postinst() {
	einfo "To enable the WebAdmin plugin in your Trac environments, you have to add:"
	einfo "	[components]"
	einfo "	webadmin.* = enabled"
	einfo "to your trac.ini files."
	einfo
	einfo "To be able to see the Admin tab, your users must have the TRAC_ADMIN permission"
	einfo "and/or the TICKET_ADMIN permission."
}
