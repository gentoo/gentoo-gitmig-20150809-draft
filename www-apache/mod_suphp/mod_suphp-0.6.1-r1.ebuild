# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_suphp/mod_suphp-0.6.1-r1.ebuild,v 1.1 2006/03/09 20:03:09 chtekk Exp $

inherit apache-module eutils

MY_P=${P/mod_/}

SETIDMODES="mode-force mode-owner mode-paranoid"

DESCRIPTION="A PHP wrapper for Apache"
HOMEPAGE="http://www.suphp.org"
SRC_URI="http://www.suphp.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE="checkpath ${SETIDMODES}"
SLOT="0"

S="${WORKDIR}/${MY_P}"

APXS1_S="${S}/src/apache"
APACHE1_MOD_CONF="70_${PN}"
APACHE1_MOD_DEFINE="SUPHP"

APXS2_S="${S}/src/apache2"
APACHE2_MOD_CONF="70_${PN}"
APACHE2_MOD_DEFINE="SUPHP"

need_apache2

pkg_setup() {
	modecnt=0
	for mode in ${SETIDMODES}; do
		if use ${mode}; then
			if [ ${modecnt} -eq 0 ]; then
				SUPHP_SETIDMODE=${mode/mode-}
				let modecnt++
			elif [ ${modecnt} -ge 1 ]; then
				die "You can only select ONE mode in your USE flags!"
			fi
		fi
	done

	if [ ${modecnt} -eq 0 ]; then
		ewarn
		ewarn "No mode selected, defaulting to paranoid!"
		ewarn
		ewarn "If you want to choose another mode, put mode-force OR mode-owner"
		ewarn "into your USE flags and run emerge again."
		ewarn
	fi

	einfo
	einfo "Using ${SUPHP_SETIDMODE/mode-} mode"
	einfo
	einfo "You can manipulate several configure options of this"
	einfo "ebuild through environment variables:"
	einfo
	einfo "SUPHP_MINUID: Minimum UID, which is allowed to run scripts (default: 1000)"
	einfo "SUPHP_MINGID: Minimum GID, which is allowed to run scripts (default: 100)"
	einfo "SUPHP_APACHEUSER: Name of the user Apache is running as (default: apache)"
	einfo "SUPHP_LOGFILE: Path to suPHP logfile (default: /var/log/apache2/suphp_log)"
	einfo

	: ${SUPHP_MINUID:=1000}
	: ${SUPHP_MINGID:=100}
	: ${SUPHP_APACHEUSER:="apache"}
	: ${SUPHP_LOGFILE:="/var/log/apache2/suphp_log"}
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	epatch "${FILESDIR}/suphp-apache22-compat.patch"
	if has_version ">=dev-libs/apr-1.0.0" ; then
		sed -e "s|apr-config|apr-1-config|g" -i configure
	fi
}

src_compile() {
	local myargs=
	use checkpath || myargs="${myargs} --disable-checkpath"

	myargs="${myargs} \
		--with-setid-mode=${SUPHP_SETIDMODE} \
	        --with-min-uid=${SUPHP_MINUID} \
	        --with-min-gid=${SUPHP_MINGID} \
	        --with-apache-user=${SUPHP_APACHEUSER} \
	        --with-logfile=${SUPHP_LOGFILE} \
	        --with-apxs=${APXS2}"
	if has_version ">=dev-libs/apr-1.0.0" ; then
		CFLAGS="$(apr-1-config --includes) $(apu-1-config --includes)" \
		econf ${myargs} || die "econf failed"
	else
		CFLAGS="$(apr-config --includes) $(apu-config --includes)" \
		econf ${myargs} || die "econf failed"
	fi

	emake || die "make failed"
}

src_install() {
	apache-module_src_install
	dosbin src/suphp

	dodoc ChangeLog doc/CONFIG

	docinto apache
	dodoc doc/apache/CONFIG doc/apache/INSTALL

	insinto /etc
	doins ${FILESDIR}/suphp.conf
}

pkg_postinst() {
	# make suphp setuid
	chmod 4755 /usr/sbin/suphp
}
