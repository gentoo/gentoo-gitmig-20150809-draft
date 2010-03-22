# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.14.ebuild,v 1.2 2010/03/22 17:15:03 ssuominen Exp $

EAPI=3
inherit autotools eutils flag-o-matic multilib prefix

DESCRIPTION="A complete ODBC driver manager"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="mirror://sourceforge/unixodbc/${P}.tar.gz
	http://dev.gentoo.org/~ssuominen/${P}-patchset-1.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="static-libs qt4"

RDEPEND=">=sys-libs/readline-6.0
	>=sys-libs/ncurses-5.6
	sys-devel/libtool
	qt4? ( x11-libs/qt-assistant:4
		x11-libs/qt-core:4
		x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_prepare() {
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patches

	# clean up old moc files and bundled libtool
	rm -rf libltdl odbcinstQ4/m*.cpp

	eautoreconf

	cp "${FILESDIR}"/odbcinst.ini "${T}"
	eprefixify "${T}"/odbcinst.ini
}

src_configure() {
	local myconf="--enable-gui=no"

	use qt4 && myconf="--enable-gui=yes"

	# 2.2.14 is not aliasing-safe
	append-flags -fno-strict-aliasing

	econf \
		--sysconfdir="${EPREFIX}/etc/${PN}" \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--enable-fdb \
		--enable-ltdllib \
		--with-qt-libraries="${EPREFIX}/usr/$(get_libdir)/qt4" \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README*
	dohtml -a gif,html,sql -r doc/*

	# http://cvs.fedoraproject.org/viewvc/rpms/unixODBC/devel/
	insinto /etc/unixODBC
	newins "${T}"/odbcinst.ini odbcinst.ini.example || die

	if use qt4; then
		newicon DataManager/LinuxODBC.xpm ${PN}.xpm
		make_desktop_entry ODBCConfig "ODBC Data Source Administrator"
	fi
}
