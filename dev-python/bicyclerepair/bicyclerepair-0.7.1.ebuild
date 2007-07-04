# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bicyclerepair/bicyclerepair-0.7.1.ebuild,v 1.11 2007/07/04 19:16:33 hawking Exp $

inherit distutils

DESCRIPTION="Bicycle Repair Man is the Python Refactoring Browser,"
HOMEPAGE="http://bicyclerepair.sourceforge.net/"
SRC_URI="mirror://sourceforge/bicyclerepair/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/python"

src_install() {
	DOCS="DESIGN"
	distutils_src_install
	rm -f ${D}/usr/bin/bikeemacs.bat
}

pkg_postinst() {
	# Enable IDLE integration if Python was compiled with tcltk.
	PYTHON_VER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	config_txt=/usr/lib/python${PYTHON_VER}/tools/idle/config.txt
	if [ -f "${config_txt}" ]; then
		if [ -z "`grep BicycleRepairMan_Idle ${config_txt}`" ]; then
			elog "Appending BicycleRepairman to IDLE.."
			echo "[BicycleRepairMan_Idle]" >> ${config_txt}
		fi
	fi
}
