#
# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
#
# Released under the GPL
#
DESCRIPTION="Discover hardware and load the appropriate drivers for that hardware."
HOMEPAGE="http://www.progeny.com/discover"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover/discover_1.5-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
DEPEND=""
RDEPEND="sys-apps/discover-data"

S=${WORKDIR}/${P}

src_compile() {
	./configure --prefix=/usr \
                --sbindir=/sbin \
                --sysconfdir=/etc \
                --mandir=/usr/share/man \
                --infodir=/usr/share/info || die "configure failed"
  emake || die
}

src_install () {
	make DESTDIR=${D} install || die
        cp ${FILESDIR}/etc-init.d-discover ${D}/etc/init.d/discover
        insinto /usr/share/discover
        doins discover/linuxrc
	dodoc BUGS AUTHORS ChangeLog NEWS README TODO ChangeLog.mandrake docs/ISA-Structure docs/PCI-Structure docs/Programming
	insinto /var/lib/discover
	prepallman
}
