# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/netscape/netscape-7.2-r1.ebuild,v 1.1 2005/06/18 16:28:14 usata Exp $

inherit eutils

DESCRIPTION="Netscape 7.x - built with Mozilla(TM)"
HOMEPAGE="http://channels.netscape.com/ns/browsers/"
SRC_URI="http://ftp.netscape.com/pub/netscape7/english/${PV}/unix/linux/sea/netscape-i686-pc-linux-gnu-sea.tar.gz"

LICENSE="MPL-1.1 NPL-1.1"

RESTRICT="nomirror"
SLOT="${PV}"
KEYWORDS="-* ~x86"
IUSE="aim flash moznomail spell"
DEPEND="virtual/x11
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	flash? ( !net-www/netscape-flash )"

S="${WORKDIR}/netscape-installer"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Removing the RunApp section to prevent Netscape from launching after installation
	# Removing the Setup Type sections because we write our own
	sed -i config.ini \
		-e "s:\(Default Location\)=.*:\1=${D}/opt/${P/-//}:" \
		-e '/\[RunApp0\]/,/^$/d' \
		-e '/\[Setup Type[0-9]*\]/,/^$/d'
	echo '[Setup Type0]' >> config.ini
	# netscape-installer segfaults if the description is missing
	echo 'Description Short=' >> config.ini
	echo 'Description Long=' >> config.ini
	local C=0
	for component in \
		                          0   'XPInstall Engine' \
		                          1   'Navigator' \
		$(useq !moznomail && echo 2 ) 'Mail & News' \
		$(useq aim        && echo 3 ) 'Instant Messenger' \
		                          4   'Personal Security Manager' \
		$(useq spell      && echo 5 ) 'Spell Checker' \
		$(false           && echo 6 ) 'Quality Feedback Agent' \
		                          7   'US English Profile Defaults' \
		                          8   'English (US) Language Pack' \
		                          9   'US Region Pack' \
		$(false           && echo 10) 'Sun Java 2' \
		$(useq flash      && echo 11) 'Macromedia Flash Player' \
		$(false           && echo 19) 'Venkman' \
		$(false           && echo 20) 'Chatzilla' \
		$(false           && echo 21) 'DOM Inspector' \
	; do
		expr "$component" : '[0-9]*$' >/dev/null || continue

		echo "C$C=Component$component" >> config.ini
		C=$((C+1))
	done
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	./netscape-installer -ms || die 'netscape-installer failed'
	dodir /usr/lib/nsbrowser
	mv ${D}/opt/${P/-//}/plugins ${D}/usr/lib/nsbrowser
	dosym /usr/lib/nsbrowser/plugins /opt/${P/-//}/plugins
	dodir /usr/bin
	cd ${D}/opt/${P/-//}/ ; epatch ${FILESDIR}/${P}-gentoo.diff
	dosym /opt/${P/-//}/netscape /usr/bin/${P}
	rm -f ${D}/usr/lib/nsbrowser/plugins/libnullplugin.so

	make_desktop_entry "${P}" "Netscape ${PV}" /opt/${P/-//}/icons/mozicon50.xpm "Network"
}
