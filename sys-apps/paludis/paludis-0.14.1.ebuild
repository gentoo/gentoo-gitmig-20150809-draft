# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paludis/paludis-0.14.1.ebuild,v 1.2 2007/01/06 00:32:18 ferdy Exp $

inherit bash-completion eutils flag-o-matic

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="contrarius cran doc glsa pink qa ruby selinux zsh-completion"

COMMON_DEPEND="
	>=app-shells/bash-3
	selinux? ( sys-libs/libselinux )
	qa? ( dev-libs/pcre++ >=dev-libs/libxml2-2.6 app-crypt/gnupg )
	glsa? ( >=dev-libs/libxml2-2.6 )
	ruby? ( >=dev-lang/ruby-1.8 )"

DEPEND="${COMMON_DEPEND}
	dev-cpp/libebt
	>=dev-cpp/libwrapiter-1.0.0
	doc? ( app-doc/doxygen media-gfx/imagemagick )"

RDEPEND="${COMMON_DEPEND}
	>=app-admin/eselect-1.0.2
	net-misc/wget
	net-misc/rsync
	!mips? ( sys-apps/sandbox )"

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-vdb-path.patch
}

src_compile() {
	local repositories=`echo default $(usev cran) | tr -s \  ,`
	local clients=`echo default $(usev contrarius) | tr -s \  ,`
	econf \
		$(use_enable doc doxygen ) \
		$(use_enable !mips sandbox ) \
		$(use_enable pink) \
		$(use_enable selinux) \
		$(use_enable qa) \
		$(use_enable ruby) \
		$(use_enable glsa) \
		--with-repositories=${repositories} \
		--with-clients=${clients} \
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
		dohtml -r -V doc/www/*
	fi

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins zsh-completion/_paludis
		doins zsh-completion/_adjutrix
		doins zsh-completion/_paludis_packages
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
	einfo "    http://paludis.pioto.org/faq.html"
	echo
}

