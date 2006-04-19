# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cdargs/cdargs-1.35.ebuild,v 1.2 2006/04/19 02:22:18 weeve Exp $

DESCRIPTION="Bookmarks and browser for the shell builtin cd command"
HOMEPAGE="http://www.skamphausen.de/software/cdargs"
SRC_URI="http://www.skamphausen.de/software/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="emacs"

DEPEND="sys-libs/ncurses"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README THANKS TODO AUTHORS

	cd ${S}/contrib
	insinto /usr/share/cdargs
	doins cdargs-bash.sh cdargs-tcsh.csh \
		|| die "failed to install contrib scripts"
	if use emacs ; then
		doins cdargs.el || die "failed to install cdargs.el"
	fi
}

pkg_postinst() {
	echo
	einfo "Add the following line to your ~/.bashrc to enable cdargs helper"
	einfo "functions/aliases in your environment:"
	einfo "[ -f /usr/share/cdargs/cdargs-bash.sh ] && \\ "
	einfo "		source /usr/share/cdargs/cdargs-bash.sh"
	einfo
	einfo "Users of tcshell will find cdargs-tcsh.csh there with a reduced"
	einfo "feature set.  See INSTALL file in the documentation directory for"
	einfo "more information."

	if use emacs ; then
		einfo
		einfo "To get an interactive cv defun in (X)Emacs load cdargs.el:"
		einfo " (setq load-path"
		einfo "       (append (list "
		einfo "        \"/usr/share/cdargs/\")"
		einfo "        load-path))"
		einfo " (require 'cdargs)"
	fi
	echo
}
