# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/kazehakase-cvs/kazehakase-cvs-20050330.ebuild,v 1.1 2005/03/30 17:21:31 nakano Exp $

inherit cvs eutils

ECVS_BRANCH=""
ECVS_SERVER="cvs.sourceforge.jp:/cvsroot/kazehakase"
ECVS_USER="anonymous"
ECVS_MODULE="kazehakase"

DESCRIPTION="Kazehakase is a browser with gecko engine like Epiphany or Galeon."
SRC_URI=""
HOMEPAGE="http://kazehakase.sourceforge.jp/"
IUSE="migemo estraier thumbnail firefox"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
LICENSE="GPL-2"

DEPEND="!firefox? ( >=www-client/mozilla-1.7 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	x11-libs/pango
	>=x11-libs/gtk+-2
	dev-util/pkgconfig
	net-misc/curl
	migemo? ( || ( app-text/migemo app-text/cmigemo ) )
	estraier? ( app-text/estraier )
	thumbnail? ( virtual/ghostscript )
	sys-devel/autoconf
	sys-devel/automake"

S="${WORKDIR}/${ECVS_MODULE}"

pkg_setup(){
	if ! use firefox; then
		local moz_use="$(</var/db/pkg/`best_version www-client/mozilla`/USE)"
		if ! has_version '>=www-client/mozilla-1.7.3-r2' && ! has gtk2 ${moz_use}
		then
			echo
			eerror
			eerror "This needs mozilla used gtk2."
			eerror "To build mozilla use gtk2, please type following command:"
			eerror
			eerror "    # USE=\"gtk2\" emerge mozilla"
			eerror
			die
		fi
	fi
}

src_unpack(){
	cvs_src_unpack || die
	cd ${S}
	# epatch ${FILESDIR}/${PN}-gentoo.patch

	mv configure.in configure.in.org
	sed -e "s/\(AC_INIT(kazehakase\|GETTEXT_PACKAGE=kazehakase\)/\1-cvs/" \
		configure.in.org > configure.in

	mv data/Makefile.am data/Makefile.am.org
	sed -e "s/^desktop_DATA = kazehakase.desktop/desktop_DATA = kazehakase-cvs.desktop/" \
		data/Makefile.am.org > data/Makefile.am

	sed -e "s/kazehakase/kazehakase-cvs/" data/kazehakase.desktop > data/kazehakase-cvs.desktop
}

src_compile(){
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.6

	./autogen.sh || die

	if use firefox; then
		geckoengine="firefox"
	else
		geckoengine="mozilla"
	fi
	econf `use_enable migemo` --program-suffix="-cvs" \
	--with-gecko-engine=${geckoengine} || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog NEWS README* TODO.ja
}

pkg_postinst(){
	if use thumbnail; then
		einfo "To enable thumbnail, "
		einfo "   1. Go to Preference."
		einfo "   2. Check \"Create thumbnail\"."
		einfo
		ewarn "Creating thumbnail process is still unstable (sometimes causes crash),"
		ewarn "but most causes of unstability are Mozilla. If you find a crash bug on"
		ewarn "Kazehakase, please confirm the following:"
		ewarn
		ewarn "   1. Load a crash page with Mozilla."
		ewarn "   2. Print preview the page."
		ewarn "   3. Close print preview window."
		ewarn "   4. Print the page to a file."
		ewarn
	fi

	einfo ""
	einfo "Many files/directories have been installed with -cvs postfix since kazehakase-cvs-20050325 "
	einfo "so that you can install kazehakase/kazehakase-cvs in the same box."
	einfo ""
	einfo "Renamed files/directories which you should know."
	einfo " /usr/bin/kazehakase-cvs"
	einfo " /etc/kazehakase-cvs"
	einfo " <your home directory>/.kazehakase-cvs"
	einfo ""
	einfo "You might want to create symbolic link .kazehakase-cvs which points to .kazehakase in your home directory."
	einfo "i.e. ln -s .kazehakase <your home directory>/.kazehakase-cvs"
	einfo ""
}

