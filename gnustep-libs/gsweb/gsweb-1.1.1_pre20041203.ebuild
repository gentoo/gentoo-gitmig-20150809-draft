# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/gsweb/gsweb-1.1.1_pre20041203.ebuild,v 1.1 2004/12/04 20:20:48 fafhrd Exp $

ECVS_CVS_COMMAND="cvs -q"
ECVS_SERVER="savannah.gnu.org:/cvsroot/gnustep"
ECVS_USER="anoncvs"
ECVS_AUTH="ext"
ECVS_MODULE="gnustep/dev-libs/${PN}"
ECVS_CO_OPTS="-P -D ${PV/*_pre}"
ECVS_UP_OPTS="-dP -D ${PV/*_pre}"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/savannah.gnu.org-gnustep"
inherit gnustep cvs eutils depend.apache

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="GNUstepWeb is a library which was designed to be compatible with WebObjects 4.x (developed by NeXT (now Apple) Inc.)."
HOMEPAGE="http://www.gnustep.org"

KEYWORDS="~ppc"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="${GS_DEPEND}
	gnustep-libs/gdl2
	x11-libs/libPropList"
RDEPEND="${GS_RDEPEND}
	gnustep-libs/gdl2
	x11-libs/libPropList
	net-www/apache"
need_apache2
IUSE="${IUSE}"

egnustep_install_domain "System"

src_unpack() {
	cvs_src_unpack
	cd ${S}/GSWeb.framework
	epatch ${FILESDIR}/1.1.1_pre-build-fixes.patch
	cd ${S}/GSWAdaptors/Apache
	epatch ${FILESDIR}/apache1-make.patch
	cd ${S}/GSWAdaptors/Apache
	epatch ${FILESDIR}/apache2-make.patch
	cd ${S}
}

src_compile() {
	cd ${S}
	egnustep_env
	econf "--prefix=$(egnustep_prefix)" || die "./configure failed"
	egnustep_make || die
	cd ${S}/GSWAdaptors/Apache
	pwd
	einfo "emake -f GNUmakefile-Apache${APACHE_VERSION}x all"
	emake -f GNUmakefile-Apache${APACHE_VERSION}x all
	ls -la
	cd ${S}
	pwd
}

src_install() {
	gnustep_src_install
	cd ${S}/GSWAdaptors/Apache
	insinto /usr/lib/apache${APACHE_VERSION#1}-extramodules
	insopts -m0755
	doins mod_gsweb.so
	cd ${S}

	insinto /etc/apache${APACHE_VERSION#1}/conf/modules.d
	doins ${FILESDIR}/${APACHE_VERSION}/90_mod_gsweb.conf

	insinto /etc/apache${APACHE_VERSION#1}/conf
	doins ${FILESDIR}/gsweb.conf

	dodir $(egnustep_system_domain)/Library/Documentation/GSWeb
	insinto $(egnustep_system_domain)/Library/Documentation/GSWeb
	doins GSWAdaptors/Doc/ConfigurationFile.html
}

pkg_postinst() {
	gnustep_pkg_postinst
	einfo "Edit /etc/conf.d/apache${APACHE_VERSION#1} and add \"-D GSWeb\" to APACHE${APACHE_VERSION#1}_OPTS"
}

