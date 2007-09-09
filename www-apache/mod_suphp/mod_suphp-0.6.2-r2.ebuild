# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_suphp/mod_suphp-0.6.2-r2.ebuild,v 1.1 2007/09/09 07:34:17 hollow Exp $

inherit apache-module autotools eutils

MY_P="${P/mod_/}"

SETIDMODES="mode-force mode-owner mode-paranoid"

KEYWORDS="~amd64 ~ppc ~x86"

DESCRIPTION="A PHP wrapper for Apache2"
HOMEPAGE="http://www.suphp.org/"
SRC_URI="http://www.suphp.org/download/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="checkpath ${SETIDMODES}"

S="${WORKDIR}/${MY_P}"

APXS2_S="${S}/src/apache2"
APACHE2_MOD_CONF="70_${PN}"
APACHE2_MOD_DEFINE="SUPHP"

need_apache2

pkg_setup() {
	modecnt=0
	for mode in ${SETIDMODES} ; do
		if use ${mode} ; then
			if [[ ${modecnt} -eq 0 ]] ; then
				SUPHP_SETIDMODE=${mode/mode-}
				let modecnt++
			elif [[ ${modecnt} -ge 1 ]] ; then
				die "You can only select ONE mode in your USE flags!"
			fi
		fi
	done

	if [[ ${modecnt} -eq 0 ]] ; then
		ewarn
		ewarn "No mode selected, defaulting to paranoid!"
		ewarn
		ewarn "If you want to choose another mode, put mode-force OR mode-owner"
		ewarn "into your USE flags and run emerge again."
		ewarn
		SUPHP_SETIDMODE=paranoid
	fi

	elog
	elog "Using ${SUPHP_SETIDMODE/mode-} mode"
	elog
	elog "You can manipulate several configure options of this"
	elog "ebuild through environment variables:"
	elog
	elog "SUPHP_MINUID: Minimum UID, which is allowed to run scripts (default: 1000)"
	elog "SUPHP_MINGID: Minimum GID, which is allowed to run scripts (default: 100)"
	elog "SUPHP_APACHEUSER: Name of the user Apache is running as (default: apache)"
	elog "SUPHP_LOGFILE: Path to suPHP logfile (default: /var/log/apache2/suphp_log)"
	elog

	apache-module_pkg_setup
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}"/${P}-handler.patch

	eautoreconf
}

src_compile() {
	local myargs=""
	use checkpath || myargs="${myargs} --disable-checkpath"

	: ${SUPHP_MINUID:=1000}
	: ${SUPHP_MINGID:=100}
	: ${SUPHP_APACHEUSER:="apache"}
	: ${SUPHP_LOGFILE:="/var/log/apache2/suphp_log"}

	myargs="${myargs} \
			--with-setid-mode=${SUPHP_SETIDMODE} \
			--with-min-uid=${SUPHP_MINUID} \
			--with-min-gid=${SUPHP_MINGID} \
			--with-apache-user=${SUPHP_APACHEUSER} \
			--with-logfile=${SUPHP_LOGFILE} \
			--with-apxs=${APXS2} \
			--with-apr=/usr"
	econf ${myargs} || die "econf failed"

	emake || die "make failed"
}

src_install() {
	apache-module_src_install
	dosbin src/suphp
	fperms 4755 /usr/sbin/suphp

	dodoc ChangeLog doc/CONFIG

	docinto apache
	dodoc doc/apache/CONFIG doc/apache/INSTALL

	insinto /etc
	doins "${FILESDIR}/suphp.conf"
}

pkg_postinst() {
	# Make sure the suphp binary is set setuid
	chmod 4755 "${ROOT}"/usr/sbin/suphp

	apache-module_pkg_postinst
}
