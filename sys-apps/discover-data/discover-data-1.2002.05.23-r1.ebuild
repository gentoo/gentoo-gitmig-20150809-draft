# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
# Released under the GPL
#
DESCRIPTION="data for discover. list of pci ids. pnp ids etc."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover-data/${PN}_${PV}-1.tar.gz"
HOMEPAGE="http://hackers.progeny.com/discover/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=""
RDEPEND=""

S=${WORKDIR}/discover-data-${P}-1

src_compile() {
  patch -p0 <${FILESDIR}/kernel-2.2-2.4.drivername.patch
  emake || die
}

src_install () {
  make DESTDIR=${D} install || die
  dodoc ChangeLog
}
