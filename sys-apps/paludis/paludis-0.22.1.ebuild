# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paludis/paludis-0.22.1.ebuild,v 1.1 2007/03/26 07:37:04 killerfox Exp $

inherit bash-completion eutils flag-o-matic

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~s390 ~sparc ~x86"
IUSE="contrarius cran doc glsa inquisitio pink qa ruby zsh-completion"

WANT_AUTOCONF="2.5"
WANT_AUTOMAKE="1.9"

COMMON_DEPEND="
	>=app-shells/bash-3.1
	qa? ( dev-libs/pcre++ >=dev-libs/libxml2-2.6 app-crypt/gnupg )
	inquisitio? ( dev-libs/pcre++ )
	glsa? ( >=dev-libs/libxml2-2.6 )
	ruby? ( >=dev-lang/ruby-1.8 )"

# Nasty hack for tr1 that will be changed whenever a proper solution is
# available. See discussion on gentoo-dev list.
COMMON_DEPEND="${COMMON_DEPEND}
	|| ( >=sys-devel/gcc-4.1.1 >=dev-libs/boost-1.33.1 )"

DEPEND="${COMMON_DEPEND}
	dev-cpp/libebt
	>=dev-cpp/libwrapiter-1.0.0
	doc? ( app-doc/doxygen media-gfx/imagemagick )
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	>=app-admin/eselect-1.0.2
	net-misc/wget
	net-misc/rsync
	!mips? ( sys-apps/sandbox )"

PROVIDE="virtual/portage"

create-paludis-user() {
	enewgroup "paludisbuild"
	enewuser "paludisbuild" -1 -1 -1 "paludisbuild"
}

pkg_setup() {
	replace-flags -Os -O2
	create-paludis-user
}

src_compile() {
	local repositories=`echo default $(usev cran) | tr -s \  ,`
	local clients=`echo default $(usev contrarius) $(usev inquisitio) | tr -s \  ,`
	econf \
		$(use_enable doc doxygen ) \
		$(use_enable !mips sandbox ) \
		$(use_enable pink) \
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
		doins zsh-completion/_inquisitio
		doins zsh-completion/_paludis_packages
	fi
}

src_test() {
	# Work around Portage bugs
	export PALUDIS_DO_NOTHING_SANDBOXY="portage sucks"
	export BASH_ENV=/dev/null

	emake check || die "Make check failed"
}

pkg_preinst() {
	create-paludis-user
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
