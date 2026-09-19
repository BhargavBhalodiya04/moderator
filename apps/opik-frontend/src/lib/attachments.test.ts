import { describe, expect, it } from "vitest";
import { isModeratorS3AttachmentUrl } from "./attachments";

describe("isModeratorS3AttachmentUrl", () => {
  it("should match path-style S3 URLs", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://s3.amazonaws.com/my-bucket/opik/attachment/file.pdf",
      ),
    ).toBe(true);
  });

  it("should match path-style S3 URLs with region", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://s3.us-east-1.amazonaws.com/my-bucket/opik/attachment/file.pdf",
      ),
    ).toBe(true);
    expect(
      isModeratorS3AttachmentUrl(
        "https://s3.eu-west-2.amazonaws.com/bucket/opik/attachment/doc.txt",
      ),
    ).toBe(true);
  });

  it("should match virtual-hosted-style S3 URLs", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://my-bucket.s3.amazonaws.com/opik/attachment/file.pdf",
      ),
    ).toBe(true);
  });

  it("should match virtual-hosted-style S3 URLs with region", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://my-bucket.s3.us-west-2.amazonaws.com/opik/attachment/file.pdf",
      ),
    ).toBe(true);
    expect(
      isModeratorS3AttachmentUrl(
        "https://bucket-name.s3.ap-southeast-1.amazonaws.com/opik/attachment/image.png",
      ),
    ).toBe(true);
  });

  it("should match URLs with query parameters (presigned URLs)", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://my-bucket.s3.us-east-1.amazonaws.com/opik/attachment/file.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=...",
      ),
    ).toBe(true);
    expect(
      isModeratorS3AttachmentUrl(
        "https://s3.us-east-1.amazonaws.com/my-bucket/opik/attachment/file.pdf?X-Amz-Expires=3600",
      ),
    ).toBe(true);
  });

  it("should reject URLs without opik/attachment path", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://s3.amazonaws.com/my-bucket/other/file.pdf",
      ),
    ).toBe(false);
    expect(
      isModeratorS3AttachmentUrl(
        "https://my-bucket.s3.amazonaws.com/some/other/path.pdf",
      ),
    ).toBe(false);
  });

  it("should reject non-S3 URLs", () => {
    expect(
      isModeratorS3AttachmentUrl("https://example.com/opik/attachment/file.pdf"),
    ).toBe(false);
    expect(isModeratorS3AttachmentUrl("https://google.com/file.pdf")).toBe(false);
  });

  it("should reject HTTP URLs (not HTTPS)", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "http://s3.amazonaws.com/my-bucket/opik/attachment/file.pdf",
      ),
    ).toBe(false);
    expect(
      isModeratorS3AttachmentUrl(
        "http://my-bucket.s3.amazonaws.com/opik/attachment/file.pdf",
      ),
    ).toBe(false);
  });

  it("should reject URLs with empty attachment path", () => {
    expect(
      isModeratorS3AttachmentUrl(
        "https://s3.amazonaws.com/my-bucket/opik/attachment/",
      ),
    ).toBe(false);
    expect(
      isModeratorS3AttachmentUrl(
        "https://my-bucket.s3.amazonaws.com/opik/attachment/",
      ),
    ).toBe(false);
  });
});
