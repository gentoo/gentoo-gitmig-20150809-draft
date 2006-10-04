# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_userdb/pam_userdb-0.99.6.3.ebuild,v 1.1 2006/10/04 07:29:41 flameeyes Exp $

inherit libtool multilib eutils pam

MY_P="Linux-PAM-${PV}"

HOMEPAGE="http://www.kernel.org/pub/linux/libs/pam/"
DESCRIPTION="Linux-PAM pam_userdb (Berkeley DB) module"

SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/${MY_P}.tar.bz2"

LICENSE="PAM"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls elibc_FreeBSD"

RDEPEND="nls? ( virtual/libintl )
	>=sys-libs/pam-0.99.6.3-r1"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

RESTRICT="confcache"

src_unpack() {
	unpack ${A}
	cd "${S}"

	elibtoolize
}

src_compile() {
	local myconf

	# don't build documentation as it doesn't seem to really work
	export SGML2PS=no
	export SGML2TXT=no
	export SGML2HTML=no
	export SGML2LATEX=no
	export PS2PDF=no

	if use hppa || use elibc_FreeBSD; then
		myconf="${myconf} --disable-pie"
	fi

	econf \
		$(use_enable nls) \
		--enable-berkdb \
		--enable-securedir=/$(get_libdir)/security \
		--enable-isadir=/$(get_libdir)/security \
		--disable-dependency-tracking \
		--disable-prelude \
		--enable-docdir=/usr/share/doc/${PF} \
		${myconf} || die "econf failed"

	cd "${S}/modules/pam_userdb"
	emake || die "emake failed"
}

src_install() {
	cd "${S}/modules/pam_userdb"
	emake DESTDIR="${D}" install || die "make install failed"

	# No, we don't really need .la files for PAM modules.
	rm -f "${D}/$(get_libdir)/security/"*.la
}
