# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Sebastian Werner <sebastian@werner-productions.de

S=${WORKDIR}/${P}
DESCRIPTION="Turboprint ${PV} - High quality commercial printer drivers"
SRC_FILE="turboprint_1_41.tgz"
SRC_URI="ftp://ftp.zedonet.com/${SRC_FILE}"

HOMEPAGE="http://www.turboprint.de/"

DEPEND=">=net-print/cups-1.1.8"

src_unpack() {

	cd ${WORKDIR}
	unpack $SRC_FILE
	cd ${S}
}

src_compile() {

  cd $S
  echo ">>> Configuring TurboPrint..."
  cat system.cfg | \
  sed s/"/usr/share/turboprint/doc"/"/usr/share/doc/turboprint"/g \
  sed s/"/usr/man"/"usr/share/man"/g \

  echo ">>> This is a binary package"

}

src_install() {
  ./install
  dodoc BUGREPORT CHANGES INSTALLATION README
}



