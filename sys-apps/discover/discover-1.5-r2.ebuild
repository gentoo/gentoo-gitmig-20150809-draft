#
# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
#
# Released under the GPL
#
# -r1 provide gentoo discover script. Create missing /var/lib/discover
#     directory
DESCRIPTION="Discover hardware and load the appropriate drivers for that hardware."

LONGDESC="
 Discover is a hardware identification system based on the libdiscover1
 library.  Discover provides a flexible interface that programs can use to
 report a wide range of information about the hardware that is installed on a
 Linux system.  In addition to reporting information, discover includes
 support for doing hardware detection at boot time.  Detection occurs in two
 stages: The first stage, which runs from an initial ramdisk (initrd), loads
 just the drivers needed to mount the root file system, and the second stage
 loads the rest (ethernet cards, sound cards, etc.)."
 
HOMEPAGE="http://www.progeny.com/discover"

SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover/discover_1.5-1.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc"

DEPEND=""

# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
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
