#
# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
#
# Released under the GPL
#
# -r1 Change some driver names that are different in 2.4
#     Fix ebuild so that upstream changelog is installed in doc dir

DESCRIPTION="data for discover. list of pci ids. pnp ids etc."

SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover-data/discover-data_1.2002.05.23-1.tar.gz"

LICENSE="GPL"
SLOT="1"
KEYWORDS="x86 ppc"

DEPEND="bash"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
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
