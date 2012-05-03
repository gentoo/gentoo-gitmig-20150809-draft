# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-workbench/mysql-workbench-5.2.39.ebuild,v 1.3 2012/05/03 02:33:10 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND=2

inherit gnome2 eutils flag-o-matic python

MY_P="${PN}-gpl-${PV}-src"

DESCRIPTION="MySQL Workbench"
HOMEPAGE="http://dev.mysql.com/workbench/"
SRC_URI="mirror://mysql/Downloads/MySQLGUITools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug doc nls static-libs"

CDEPEND="dev-db/sqlite:3
	>=x11-libs/gtk+-2.6:2
	dev-libs/glib:2
	gnome-base/libglade:2.0
	dev-libs/libsigc++:2
	dev-libs/boost
	>=dev-cpp/ctemplate-0.95
	>=dev-libs/libxml2-2.6.2:2
	>=dev-cpp/glibmm-2.14:2
	>=dev-cpp/gtkmm-2.14:2.4
	dev-libs/libzip
	>=virtual/mysql-5.1
	dev-libs/libpcre
	virtual/opengl
	>=dev-lang/lua-5.1[deprecated]
	x11-libs/pango
	|| ( sys-libs/e2fsprogs-libs
		dev-libs/ossp-uuid )
	>=x11-libs/cairo-1.5.12[svg]
	dev-python/pexpect
	dev-python/paramiko
	doc? ( dev-python/pysqlite:2 )
	nls? ( sys-devel/gettext )"
RDEPEND="${CDEPEND}
	app-admin/sudo
	sys-apps/net-tools"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"/"${MY_P}"

pkg_setup() {
	# Make sure we use Python 2 since the code is not compatible with 3.
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# ifconfig isn't in the normal path
	sed -i -e 's:ifconfig:/sbin/ifconfig:' plugins/wb.admin/backend/wb_server_control.py || die

	# paramiko 1.7.7.1 is newer, update version range check:
	# http://bugs.mysql.com/bug.php?id=63750
	sed -i -e 's/4,5,6/4,5,6,7/' plugins/wb.admin/backend/wb_admin_ssh.py || die

	# Remove hardcoded CXXFLAGS
	sed -i -e 's/debug_flags="-ggdb3 /debug_flags="/' configure || die
	sed -i -e 's/-O0 -g3//' ext/scintilla/gtk/Makefile.in ext/scintilla/gtk/Makefile.am || die

	# Remove bundled ctemplate version to make sure we use the system
	# version, but leave a directory to avoid confusing configure, bug
	# 357539.
	rm -rf ext/ctemplate || die
	mkdir -p ext/ctemplate/ctemplate-src || die

	epatch "${FILESDIR}/${P}-glib-2.32.patch"
}

src_configure() {
	econf \
		$(use_enable nls i18n) \
		$(use_enable debug) \
		$(use_enable static-libs static)
}

src_install() {
	emake install DESTDIR="${D}" || die
	find "${ED}" -name '*.la' -delete || die
}
