#
# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
#
# Released under the GPL
#
DESCRIPTION="data for discover. list of pci ids. pnp ids etc."

SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover-data/discover-data_1.2002.05.23-1.tar.gz"

LICENSE="GPL"
SLOT="1"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="bash"

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
RDEPEND=""

S=${WORKDIR}/discover-data-${P}-1

src_compile() {
  emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	todoc ChangeLog
}
