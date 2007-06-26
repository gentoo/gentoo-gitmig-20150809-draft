# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/straw/straw-0.26.ebuild,v 1.3 2007/06/26 02:36:07 mr_bones_ Exp $

inherit gnome2 python distutils virtualx

DESCRIPTION="RSS/RDF News Aggregator"
HOMEPAGE="http://www.gnome.org/projects/straw/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"

RDEPEND="${DEPEND}
	gnome-base/gconf
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnome-2.0.1
	>=dev-python/gnome-python-1.99.13
	>=dev-python/pygtk-2.6
	>=dev-python/bsddb3-3.4.0
	>=dev-python/egenix-mx-base-2
	dev-python/gnome-python-extras
	dev-python/dbus-python
	!ppc? ( >=dev-python/adns-python-1.0.0 )"

# REMIND : egenix-mx-base is only needed for the conversion of
# pre 0.22 straw databases. It should be removed at some point.
# foser <foser@gentoo.org> 18 Feb 2004

pkg_setup() {
	export maketype="python"
	if ! echo "import gtkhtml2" | virtualmake; then
		eerror "The gnome-python-extras gtkhtml2 module was not found."
		eerror "Try unmerging gnome-python and gnome-python-extras"
		eerror "And then try emerging straw again."
		die "missing gtkhtml2 python module"
	fi
}

src_unpack() {
	gnome2_src_unpack
	sed -i \
		-e 's/bsddb.db/bsddb3.db/' \
		"${S}/setup.py" || die "sed failed"
}

# This about of virtualmake in src_compile and src_install are
# pretty horrible.. why can't I compile gtk base modules in
# distutils without that (ps. I'm the upstream guy to blame)
# Olivier Crete <tester@gentoo.org>

src_compile() {
	export maketype="distutils_src_compile"
	virtualmake || die "compilation failed"
}

src_install() {
	# work around bug in straw's install script
	export maketype="distutils_src_install"
	virtualmake \
		--prefix=/usr \
		--sysconfdir=${D}/etc \
		--disable-schemas-install
}

pkg_postinst() {

	distutils_pkg_postinst
	gnome2_pkg_postinst # need this for gconf schemas

	echo
	einfo "Consult the README if you have database conversion problems on startup."
	echo

}

pkg_postrm() {

	distutils_pkg_postrm
	gnome2_pkg_postrm

}
