# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.3.5.ebuild,v 1.1 2008/02/02 22:22:54 tove Exp $

inherit eutils multilib

LOVERS_PV=0.5
LOVERS_P=zsh-lovers-${LOVERS_PV}

DESCRIPTION="UNIX Shell similar to the Korn shell"
HOMEPAGE="http://www.zsh.org/"
SRC_URI="ftp://ftp.zsh.org/pub/${P}.tar.bz2
	examples? ( http://www.grml.org/repos/zsh-lovers_${LOVERS_PV}.orig.tar.gz )
	doc? ( ftp://ftp.zsh.org/pub/${P}-doc.tar.bz2 )"

LICENSE="ZSH"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="maildir static doc examples pcre caps unicode"

RDEPEND=">=sys-libs/ncurses-5.1
	caps? ( sys-libs/libcap )
	pcre? ( >=dev-libs/libpcre-3.9 )"
DEPEND="sys-apps/groff
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix zshall problem with soelim
	ln -s Doc man1
	mv Doc/zshall.1 Doc/zshall.1.soelim
	soelim Doc/zshall.1.soelim > Doc/zshall.1

	epatch "${FILESDIR}/${PN}"-init.d-gentoo.diff
}

src_compile() {
	local myconf=

	if use static ; then
		myconf="${myconf} --disable-dynamic"
		LDFLAGS="${LDFLAGS} -static"
	fi

	econf \
		--bindir=/bin \
		--libdir=/usr/$(get_libdir) \
		--enable-etcdir=/etc/zsh \
		--enable-zshenv=/etc/zsh/zshenv \
		--enable-zlogin=/etc/zsh/zlogin \
		--enable-zlogout=/etc/zsh/zlogout \
		--enable-zprofile=/etc/zsh/zprofile \
		--enable-zshrc=/etc/zsh/zshrc \
		--enable-fndir=/usr/share/zsh/${PV%_*}/functions \
		--enable-site-fndir=/usr/share/zsh/site-functions \
		--enable-function-subdirs \
		--enable-ldflags="${LDFLAGS}" \
		--with-curses-terminfo \
		--with-tcsetpgrp \
		$(use_enable maildir maildir-support) \
		$(use_enable pcre) \
		$(use_enable caps cap) \
		$(use_enable unicode multibyte) \
		${myconf} || die "configure failed"

	if use static ; then
		# compile all modules statically, see Bug #27392
		# removed cap and curses because linking failes
		sed -i \
			-e "s/link=no/link=static/g" \
			-e 's/cap.mdd link=static/cap.mdd link=no/' \
			-e 's/curses.mdd link=static/curses.mdd link=no/' \
			config.modules || die
#	else
#		sed -i -e "/LIBS/s%-lpcre%/usr/$(get_libdir)/libpcre.a%" Makefile
	fi

	emake || die "make failed"
}

src_test() {
	local f=
	for f in /dev/pt* ; do
		addpredict "$f"
	done
	make check || ewarn "make check failed"
}

src_install() {
	emake DESTDIR="${D}" install install.info || die

	# Bug 207019
	rm "${D}"/bin/${P} || die

	insinto /etc/zsh
	doins "${FILESDIR}"/zprofile || die

	keepdir /usr/share/zsh/site-functions
	insinto /usr/share/zsh/${PV%_*}/functions/Prompts
	doins "${FILESDIR}"/prompt_gentoo_setup || die

	# install miscellaneous scripts; bug #54520
	local i
	sed -i -e "s:/usr/local:/usr:g" "${S}"/{Util,Misc}/* || die
	for i in Util Misc ; do
		insinto /usr/share/zsh/${PV%_*}/${i}
		doins ${i}/* || die
	done

	dodoc ChangeLog* META-FAQ NEWS README config.modules

	if use doc ; then
		dohtml -r "${S}"/Doc/* || die
		insinto /usr/share/doc/${PF}
		doins Doc/zsh.{dvi,pdf} || die
	fi

	if use examples ; then
		cd "${WORKDIR}/${LOVERS_P}"
		doman  zsh-lovers.1    || die "doman zsh-lovers failed"
		dohtml zsh-lovers.html || die "dohtml zsh-lovers failed"
		docinto zsh-lovers
		dodoc zsh.vim README
		insinto /usr/share/doc/${PF}/zsh-lovers
		doins zsh-lovers.{ps,pdf} refcard.{dvi,ps,pdf} || die
		doins -r zsh_people || die "doins zsh_people failed"
		cd -
	fi

	docinto StartupFiles
	dodoc StartupFiles/z*
}

pkg_postinst() {
	# should link to http://www.gentoo.org/doc/en/zsh.xml
	elog
	elog "If you want to enable Portage completions and Gentoo prompt,"
	elog "emerge app-shells/zsh-completion and add"
	elog "	autoload -U compinit promptinit"
	elog "	compinit"
	elog "	promptinit; prompt gentoo"
	elog "to your ~/.zshrc"
	elog
	elog "Also, if you want to enable cache for the completions, add"
	elog "	zstyle ':completion::complete:*' use-cache 1"
	elog "to your ~/.zshrc"
	elog
}
