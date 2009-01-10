# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paludis/paludis-0.34.0_alpha1.ebuild,v 1.1 2009/01/10 23:44:10 coldwind Exp $

inherit bash-completion eutils flag-o-matic

DESCRIPTION="paludis, the other package mangler"
HOMEPAGE="http://paludis.pioto.org/"
SRC_URI="http://paludis.pioto.org/download/${P}.tar.bz2"

IUSE="doc inquisitio portage pink python-bindings qa ruby-bindings vim-syntax visibility xml zsh-completion"
LICENSE="GPL-2 vim-syntax? ( vim )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

COMMON_DEPEND="
	>=app-admin/eselect-1.0.2
	>=app-admin/eselect-news-20071201
	>=app-shells/bash-3
	inquisitio? ( dev-libs/pcre++ )
	python-bindings? ( >=dev-lang/python-2.4 >=dev-libs/boost-1.33.1-r1 )
	qa? ( dev-libs/pcre++ >=dev-libs/libxml2-2.6 app-crypt/gnupg )
	ruby-bindings? ( >=dev-lang/ruby-1.8 )
	xml? ( >=dev-libs/libxml2-2.6 )"

DEPEND="${COMMON_DEPEND}
	doc? (
		|| ( >=app-doc/doxygen-1.5.3 <=app-doc/doxygen-1.5.1 )
		media-gfx/imagemagick
		python-bindings? ( dev-python/epydoc dev-python/pygments )
		ruby-bindings? ( dev-ruby/syntax dev-ruby/allison )
	)
	dev-util/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	sys-apps/sandbox"

# Keep this as a PDEPEND. It avoids issues when Paludis is used as the
# default virtual/portage provider.
PDEPEND="
	vim-syntax? ( >=app-editors/vim-core-7 )"

PROVIDE="virtual/portage"

create-paludis-user() {
	enewgroup "paludisbuild"
	enewuser "paludisbuild" "-1" "-1" "/var/tmp/paludis" "paludisbuild"
}

pkg_setup() {
	create-paludis-user
}

src_compile() {
	local repositories=`echo default unpackaged | tr -s \  ,`
	local clients=`echo default accerso adjutrix importare \
		$(usev inquisitio ) instruo paludis reconcilio | tr -s \  ,`
	local environments=`echo default $(usev portage ) | tr -s \  ,`
	econf \
		$(use_enable doc doxygen ) \
		$(use_enable pink ) \
		$(use_enable qa ) \
		$(use_enable ruby-bindings ruby ) \
		$(useq ruby-bindings && useq doc && echo --enable-ruby-doc ) \
		$(use_enable python-bindings python ) \
		$(useq python-bindings && useq doc && echo --enable-python-doc ) \
		$(use_enable xml ) \
		$(use_enable vim-syntax vim ) \
		$(use_enable visibility ) \
		--with-vim-install-dir=/usr/share/vim/vimfiles \
		--enable-sandbox \
		--with-repositories=${repositories} \
		--with-clients=${clients} \
		--with-environments=${environments} \
		|| die "econf failed"

	emake ${FIXED_MAKEOPTS} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS README ChangeLog NEWS

	BASH_COMPLETION_NAME="adjutrix" dobashcompletion bash-completion/adjutrix
	BASH_COMPLETION_NAME="paludis" dobashcompletion bash-completion/paludis
	BASH_COMPLETION_NAME="accerso" dobashcompletion bash-completion/accerso
	BASH_COMPLETION_NAME="importare" dobashcompletion bash-completion/importare
	BASH_COMPLETION_NAME="instruo" dobashcompletion bash-completion/instruo
	BASH_COMPLETION_NAME="reconcilio" dobashcompletion bash-completion/reconcilio
	use qa && \
		BASH_COMPLETION_NAME="qualudis" \
		dobashcompletion bash-completion/qualudis
	use inquisitio && \
		BASH_COMPLETION_NAME="inquisitio" \
		dobashcompletion bash-completion/inquisitio

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins zsh-completion/_paludis
		doins zsh-completion/_adjutrix
		doins zsh-completion/_importare
		doins zsh-completion/_reconcilio
		use inquisitio && doins zsh-completion/_inquisitio
		doins zsh-completion/_paludis_packages
	fi
}

src_test() {
	# Work around Portage bugs
	export PALUDIS_DO_NOTHING_SANDBOXY="portage sucks"
	export BASH_ENV=/dev/null

	if [[ `id -u` == 0 ]] ; then
		export PALUDIS_REDUCED_UID=0
		export PALUDIS_REDUCED_GID=0
	fi

	if ! emake check ; then
		eerror "Tests failed. Looking for file for you to add to your bug report..."
		find "${S}" -type f -name '*.epicfail' -or -name '*.log' | while read a ; do
			eerror "	$a"
		done
		die "Make check failed."
	fi
}

pkg_postinst() {
	# Remove the symlink created by app-admin/eselect-news
	if [[ -L "${ROOT}/var/lib/paludis/news" ]] ; then
		rm "${ROOT}/var/lib/paludis/news"
	fi
}
