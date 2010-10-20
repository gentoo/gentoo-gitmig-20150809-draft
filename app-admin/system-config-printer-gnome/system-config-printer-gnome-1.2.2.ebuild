# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-printer-gnome/system-config-printer-gnome-1.2.2.ebuild,v 1.7 2010/10/20 18:27:43 reavertm Exp $

EAPI="3"

PYTHON_DEPEND="2"
WANT_AUTOMAKE="1.11"
inherit python autotools

MY_P="${PN%-gnome}-${PV}"

DESCRIPTION="GNOME frontend for a Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/1.2/${MY_P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~sh ~sparc x86"
SLOT="0"
IUSE="gnome-keyring"

# Needs cups running, bug 284005
RESTRICT="test"

RDEPEND="
	>=app-admin/system-config-printer-common-${PV}
	dev-python/libgnome-python
	dev-python/notify-python
	>=dev-python/pygtk-2.4
	dev-python/pyxml
	gnome-keyring? ( dev-python/gnome-keyring-python )
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/xmlto-0.0.22
	dev-util/intltool
	sys-devel/gettext
"

APP_LINGUAS="ar as bg bn_IN bn bs ca cs cy da de el en_GB es et fa fi fr gu he
hi hr hu hy id is it ja ka kn ko lo lv mai mk ml mr ms nb nl nn or pa pl pt_BR
pt ro ru si sk sl sr@latin sr sv ta te th tr uk vi zh_CN zh_TW"
for X in ${APP_LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/${P}-split.patch"

	# Upstream bug #587744
	epatch "${FILESDIR}/${P}-cupspk-fileget-tmp.patch"

	eautoreconf
}

src_configure() {
	local myconf

	# Disable installation of translations when LINGUAS not chosen
	if [[ -z "${LINGUAS}" ]]; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls"
	fi

	econf ${myconf}
}

src_install() {
	dodoc AUTHORS ChangeLog README || die "dodoc failed"

	emake DESTDIR="${D}" install || die "emake install failed"

	python_convert_shebangs -q -r $(python_get_version) "${D}"
}

pkg_postrm() {
	python_mod_cleanup /usr/share/system-config-printer
}
