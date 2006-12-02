# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paludis/paludis-0.12.0.ebuild,v 1.1 2006/12/02 20:30:22 hansmi Exp $

inherit bash-completion flag-o-matic eutils

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="http://paludis.berlios.de/"
SRC_URI="http://download.berlios.de/paludis/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="doc pink selinux qa ruby glsa"

DEPEND="
	dev-cpp/libebt
	>=dev-cpp/libwrapiter-1.0.0
	>=app-shells/bash-3
	>=sys-devel/autoconf-2.59
	=sys-devel/automake-1.9*
	doc? ( app-doc/doxygen )
	selinux? ( sys-libs/libselinux )
	qa? (
		dev-libs/pcre++
		>=dev-libs/libxml2-2.6
		app-crypt/gnupg
		dev-util/pkgconfig )
	glsa? (
		>=dev-libs/libxml2-2.6
		dev-util/pkgconfig )
	ruby? ( >=dev-lang/ruby-1.8 )"

RDEPEND="
	>=app-admin/eselect-1.0.2
	>=app-shells/bash-3
	net-misc/wget
	net-misc/rsync
	qa? (
		dev-libs/pcre++
		>=dev-libs/libxml2-2.6
		app-crypt/gnupg )
	glsa? ( >=dev-libs/libxml2-2.6 )
	!mips? ( sys-apps/sandbox )
	selinux? ( sys-libs/libselinux )
	ruby? ( >=dev-lang/ruby-1.8 )"

PROVIDE="virtual/portage"

pkg_setup() {
	use amd64 && replace-flags -Os -O2
	if is-ldflagq -Wl,--as-needed || is-ldflagq --as-needed ; then
		echo
		ewarn "Stripping as-needed from LDFLAGS."
		ewarn "You should not set this variable globally. Please read:"
		ewarn "    http://ciaranm.org/show_post.pl?post_id=13"
		echo
		epause 10
	fi
	filter-ldflags -Wl,--as-needed --as-needed
}

src_compile() {
	econf \
		$(use_enable doc doxygen ) \
		$(use_enable !mips sandbox ) \
		$(use_enable pink) \
		$(use_enable selinux) \
		$(use_enable glsa) \
		$(use_enable qa) \
		$(use_enable ruby) \
		--disable-gtk --disable-gtk-tests \
		|| die "econf failed"

	emake || die "emake failed"
	if use doc ; then
		make doxygen || die "make doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README ChangeLog NEWS

	BASH_COMPLETION_NAME="adjutrix" dobashcompletion bash-completion/adjutrix
	BASH_COMPLETION_NAME="paludis" dobashcompletion bash-completion/paludis
	use qa && \
		BASH_COMPLETION_NAME="qualudis" dobashcompletion bash-completion/qualudis

	if use doc ; then
		dohtml -r -V doc/html/
	fi
}

src_test() {
	# Work around Portage bugs
	export PALUDIS_DO_NOTHING_SANDBOXY="portage sucks"
	export BASH_ENV=/dev/null

	emake check || die "Make check failed"
}

pkg_postinst() {
	if use bash-completion ; then
		echo
		einfo "The following bash completion scripts have been installed:"
		einfo "  paludis"
		einfo "  adjutrix"
		use qa && einfo "  qualudis"
		einfo
		einfo "To enable these scripts, run:"
		einfo "  eselect bashcomp enable <scriptname>"
	fi

	echo
	einfo "Before using Paludis and before reporting issues, you should read:"
	einfo "    http://paludis.berlios.de/KnownIssues.html"
	echo
	einfo "Paludis 0.12.0 has various new cache options. Read:"
	einfo "    http://paludis.berlios.de/CacheFiles.html"
	echo
}

