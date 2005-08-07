# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_suphp/mod_suphp-0.6.0.ebuild,v 1.2 2005/08/07 13:00:00 hollow Exp $

inherit apache-module eutils

MY_P=${P/mod_/}

DESCRIPTION="A PHP wrapper for Apache"
HOMEPAGE="http://www.suphp.org"
SRC_URI="http://www.suphp.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
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
	einfo
	einfo "You can manipulate several configure options of this"
	einfo "ebuild through environment variables:"
	einfo
	einfo "SUPHP_MINUID: Minimum UID, which is allowed to run scripts (default: 1000)"
	einfo "SUPHP_MINGID: Minimum GID, which is allowed to run scripts (default: 100)"
	einfo "SUPHP_APACHEUSER: Name of the user Apache is running as (default: apache)"
	einfo "SUPHP_LOGFILE: Path to suPHP logfile (default: /var/log/apache2/suphp_log)"
	einfo "SUPHP_SETIDMODE: Mode to use for setting UID/GID (default: paranoid)"
	einfo "                 MODE can be on of owner, config or paranoid"
	einfo

	: ${SUPHP_MINUID:=1000}
	: ${SUPHP_MINGID:=100}
	: ${SUPHP_APACHEUSER:="apache"}
	: ${SUPHP_LOGFILE:="/var/log/apache2/suphp_log"}
	: ${SUPHP_SETIDMODE:="paranoid"}
}

src_compile() {
	local myargs=

	myargs="--with-setid-mode=${SUPHP_SETIDMODE} \
	        --with-min-uid=${SUPHP_MINUID} \
	        --with-min-gid=${SUPHP_MINGID} \
	        --with-apache-user=${SUPHP_APACHEUSER} \
	        --with-logfile=${SUPHP_LOGFILE} \
	        --disable-checkpath \
	        --with-apxs=${APXS2}"

	CFLAGS="$(apr-config --includes) $(apu-config --includes)" \
	econf ${myargs} || die "econf failed"

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
