# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.13.9.ebuild,v 1.1 2011/09/13 22:39:39 neurogeek Exp $

EAPI="4"

inherit versionator

DESCRIPTION="Zope 2 application server / web framework"
HOMEPAGE="http://www.zope.org http://zope2.zope.org http://pypi.python.org/pypi/Zope2 https://launchpad.net/zope2"
SRC_URI=""

LICENSE="ZPL"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PROPERTIES="interactive"

pkg_pretend() {
	eerror "This ebuild does NOT install Zope."
	eerror "Zope ebuilds are now maintained in Progress Overlay."
	eerror "Install app-portage/layman and add Progress Overlay:"
	eerror "# layman -a progress"
	eerror "You should now abort installation of this ebuild using Ctrl+C."
	eerror "If you want to continue installation of this ebuild, then enter \"I want to install this ebuild.\"."

	read input
	if [[ "${input}" != "I want to install this ebuild." ]]; then
		die "Use Zope from Progress Overlay"
	fi
}
