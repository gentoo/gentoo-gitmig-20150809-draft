# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/zsh-4.3.2.ebuild,v 1.4 2006/09/03 06:04:34 vapier Exp $

inherit eutils multilib

DESCRIPTION="UNIX Shell similar to the Korn shell"
HOMEPAGE="http://www.zsh.org/"
SRC_URI="ftp://ftp.zsh.org/pub/${P}.tar.bz2
	doc? ( ftp://ftp.zsh.org/pub/${P}-doc.tar.bz2 )"

LICENSE="ZSH"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc-macos ~s390 ~sh ~sparc ~x86"
IUSE="maildir ncurses static doc pcre cap unicode"

RDEPEND="pcre? ( >=dev-libs/libpcre-3.9 )
	cap? ( sys-libs/libcap )
	ncurses? ( >=sys-libs/ncurses-5.1 )"
DEPEND="sys-apps/groff
	>=sys-apps/sed-4
	${RDEPEND}"

src_unpack() {
	unpack ${P}.tar.bz2
	use doc && unpack ${P}-doc.tar.bz2
	cd ${S}
	epatch ${FILESDIR}/${PN}-init.d-gentoo.diff
	cd ${S}/Doc
	ln -sf . man1
	# fix zshall problem with soelim
	soelim zshall.1 > zshall.1.soelim
	mv zshall.1.soelim zshall.1
}

src_compile() {
	local myconf

	use static && myconf="${myconf} --disable-dynamic" \
		&& LDFLAGS="${LDFLAGS} -static"

	if use ppc-macos; then
		LDFLAGS="${LDFLAGS} -Wl,-x"
		myconf="${myconf} --enable-libs=-liconv"
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
		--with-tcsetpgrp \
		$(use_with ncurses curses-terminfo) \
		$(use_enable maildir maildir-support) \
		$(use_enable pcre) \
		$(use_enable cap) \
		$(use_enable unicode multibyte) \
		${myconf} || die "configure failed"

	if use static ; then
		# compile all modules statically, see Bug #27392
		sed -i -e "s/link=no/link=static/g" \
			-e "s/load=no/load=yes/g" \
			config.modules || die
	else
		# avoid linking to libs in /usr/lib, see Bug #27064
		sed -i -e "/LIBS/s%-lpcre%/usr/$(get_libdir)/libpcre.a%" \
			Makefile || die
	fi

	# emake still b0rks
	emake -j1 || die "make failed"
}

src_test() {
	for f in /dev/pt* ; do
		addpredict $f
	done
	make check || die "make check failed"
}

src_install() {
	einstall \
		bindir=${D}/bin \
		libdir=${D}/usr/$(get_libdir) \
		fndir=${D}/usr/share/zsh/${PV%_*}/functions \
		sitefndir=${D}/usr/share/zsh/site-functions \
		scriptdir=${D}/usr/share/zsh/${PV%_*}/scripts \
		install.bin install.man install.modules \
		install.info install.fns || die "make install failed"

	insinto /etc/zsh
	doins ${FILESDIR}/zprofile

	keepdir /usr/share/zsh/site-functions
	insinto /usr/share/zsh/${PV%_*}/functions/Prompts
	doins ${FILESDIR}/prompt_gentoo_setup || die

	# install miscellaneous scripts; bug #54520
	sed -i -e "s:/usr/local:/usr:g" {Util,Misc}/* || "sed failed"
	insinto /usr/share/zsh/${PV%_*}/Util
	doins Util/* || die "doins Util scripts failed"
	insinto /usr/share/zsh/${PV%_*}/Misc
	doins Misc/* || die "doins Misc scripts failed"

	dodoc ChangeLog* META-FAQ README INSTALL LICENCE config.modules

	if use doc ; then
		dohtml Doc/*
		insinto /usr/share/doc/${PF}
		doins Doc/zsh{.dvi,_us.ps,_a4.ps}
	fi

	docinto StartupFiles
	dodoc StartupFiles/z*
}

pkg_preinst() {
	# Our zprofile file does the job of the old zshenv file
	# Move the old version into a zprofile script so the normal
	# etc-update process will handle any changes.
	if [ -f /etc/zsh/zshenv -a ! -f /etc/zsh/zprofile ]; then
		mv /etc/zsh/zshenv /etc/zsh/zprofile
	fi
}

pkg_postinst() {
	einfo
	einfo "If you want to enable Portage completions and Gentoo prompt,"
	einfo "emerge app-shells/zsh-completion and add"
	einfo "	autoload -U compinit promptinit"
	einfo "	compinit"
	einfo "	promptinit; prompt gentoo"
	einfo "to your ~/.zshrc"
	einfo
	einfo "Also, if you want to enable cache for the completions, add"
	einfo "	zstyle ':completion::complete:*' use-cache 1"
	einfo "to your ~/.zshrc"
	einfo
	# see Bug 26776
	ewarn
	ewarn "If you are upgrading from zsh-4.0.x you may need to"
	ewarn "remove all your old ~/.zcompdump files in order to use"
	ewarn "completion.  For more info see zcompsys manpage."
	ewarn
}
