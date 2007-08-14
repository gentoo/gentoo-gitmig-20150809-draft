# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paludis/paludis-0.24.6.ebuild,v 1.1 2007/08/14 20:13:40 peper Exp $

inherit bash-completion eutils flag-o-matic

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

IUSE="contrarius cran doc glsa inquisitio portage pink qa ruby vim-syntax
	zsh-completion"
LICENSE="GPL-2 vim-syntax? ( vim )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

COMMON_DEPEND="
	>=app-admin/eselect-1.0.2
	app-admin/eselect-news
	>=app-shells/bash-3
	qa? ( dev-libs/pcre++ >=dev-libs/libxml2-2.6 app-crypt/gnupg )
	inquisitio? ( dev-libs/pcre++ )
	glsa? ( >=dev-libs/libxml2-2.6 )
	ruby? ( >=dev-lang/ruby-1.8 )
	virtual/c++-tr1-functional
	virtual/c++-tr1-memory
	virtual/c++-tr1-type-traits"

DEPEND="${COMMON_DEPEND}
	dev-cpp/libebt
	>=dev-cpp/libwrapiter-1.0.0
	doc? ( app-doc/doxygen media-gfx/imagemagick )"

RDEPEND="${COMMON_DEPEND}
	net-misc/wget
	net-misc/rsync
	sys-apps/sandbox"

# Keep vim as a PDEPEND. It avoids issues when Paludis is used as the
# default virtual/portage provider.
PDEPEND="
	vim-syntax? ( >=app-editors/vim-core-7 )"

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
	local repositories=`echo default $(usev cran ) | tr -s \  ,`
	local clients=`echo default $(usev contrarius ) $(usev inquisitio ) | tr -s \  ,`
	local environments=`echo default $(usev portage ) | tr -s \  ,`
	econf \
		$(use_enable doc doxygen ) \
		$(use_enable pink ) \
		$(use_enable qa ) \
		$(use_enable ruby ) \
		$(use_enable glsa ) \
		$(use_enable vim-syntax vim ) \
		--with-vim-install-dir=/usr/share/vim/vimfiles \
		--enable-sandbox \
		--with-repositories=${repositories} \
		--with-clients=${clients} \
		--with-environments=${environments} \
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
		BASH_COMPLETION_NAME="qualudis" \
		dobashcompletion bash-completion/qualudis
	use contrarius && \
		BASH_COMPLETION_NAME="contrarius" \
		dobashcompletion bash-completion/contrarius
	use inquisitio && \
		BASH_COMPLETION_NAME="inquisitio" \
		dobashcompletion bash-completion/inquisitio

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
		use contrarius && einfo "  contrarius"
		use inquisitio && einfo "  inquisitio"
		einfo
		einfo "To enable these scripts, run:"
		einfo "  eselect bashcomp enable <scriptname>"
	fi

	echo
	einfo "Before using Paludis and before reporting issues, you should read:"
	einfo "    http://paludis.pioto.org/faq.html"
	echo
}
